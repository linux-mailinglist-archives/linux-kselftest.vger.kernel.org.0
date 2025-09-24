Return-Path: <linux-kselftest+bounces-42260-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06444B9C34C
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Sep 2025 22:54:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9455170F6C
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Sep 2025 20:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70B4264636;
	Wed, 24 Sep 2025 20:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OSWGhDHF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75DDA2236E8;
	Wed, 24 Sep 2025 20:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758747263; cv=fail; b=mjPRi4LkWwpo/M+4/mkL5ocLVyKy/1XEeVEdbrmdwBo/+nqOC2FgiXoXZWz2T+D5VxTZbz5eTuntGKQw97gKqMSQ+eUFRC+4xohVPEqiUjVSqdbqjGajcqC92RU2MKETiFKO96NTpUNpUNJ4q1u6I0vXp3D3SUT3uIBFkQc7U+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758747263; c=relaxed/simple;
	bh=xGW2BFQgvRsPLH9RiwXgQNFRFri1WYkas4Z4M+n+QEU=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=fBcK2Y6HmYYI72vxW/wKhNz5EOTwBFPu5n9GlaWgpgaanFQZt/vYhD3HKJR0+PnFViK2xN/v9eob+y5vLkaZ6978EaXpFHp9lEbdl2CVwC7RlSvo3L44YsjaANsvx5U9tMx98V37zkm7cyWNnw55eQNmt6urgJRzrlicg+H4adQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OSWGhDHF; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758747261; x=1790283261;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=xGW2BFQgvRsPLH9RiwXgQNFRFri1WYkas4Z4M+n+QEU=;
  b=OSWGhDHFdKXeA++pWkYZpyhl5f1pB9AZgFWQUWVi4//iz/DdiJ4r98Dx
   jjzmMo0b7JUzEEr7x7uE0F2lf9KzvcN+SvhnH7LRsn7JRIZjCOQ1KFnrN
   MxDBdahocNw+xqE/E7L2DUYXG/07QYWk93thJ8Tx/1NUMQRVNTIrmflwx
   CUUEV0YalODjULOxljgwI92ow9Y0KtA3YzUAqwSmTQbFCRYgHM3ZRZQjD
   Oga5Y+qP+XzsrCj6p9ahNwPsRv7gfBiiGG+gRiKSnLgXR24EjdTRUhDfH
   i2Dvfc9cNaF1UeofhfUtqm+t72dwJqdlz00HfMYdW7gZdRU1VHmtjXF4N
   Q==;
X-CSE-ConnectionGUID: 09v2MoQ7TsWlmOXaeJH0xw==
X-CSE-MsgGUID: 09ku8ATyR2yDzQsRnlwdLw==
X-IronPort-AV: E=McAfee;i="6800,10657,11563"; a="60947478"
X-IronPort-AV: E=Sophos;i="6.18,291,1751266800"; 
   d="scan'208";a="60947478"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 13:54:20 -0700
X-CSE-ConnectionGUID: J9jwqp3MQCKgG1uiEYlErQ==
X-CSE-MsgGUID: pQvC8WGlSZWaA9v+djDGjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,291,1751266800"; 
   d="scan'208";a="182411488"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 13:54:21 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 24 Sep 2025 13:54:20 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 24 Sep 2025 13:54:20 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.0) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 24 Sep 2025 13:54:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lJ3iDqh+oiyOgdVmvYWn4CBWoICmnl100YyLfO/igzOCFy+UKbx1RxO1pkt29fK/8C5iftneDCrDW7B4OMaGtinzZ49cV8gHhc8US8P7Z7Y9I9I2rdqr5B34vcy814paTa7Sp9KmAXilz2XFceGwsEfmIN1qyFr44rAFbLP3gQkJPQ/zg1Z4SznZmcjL0PJmnhs6b5W586yc/YWDgBq8gE9DgTAWwkPTp/kzacywg+MPDqSUSMpQzOMAbXF8qkiZsUKxIzLBd/8Xf3/dGGkm3NyvakUPRT2BA5UDWdi/zbhFm5r5Ge2TvmV4HF/RA5UoTE3ogILfZciD1SGaGTQkdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Aw4pdu2hFITMYBdCkYfFgY3mDJ+1b2nnGWFJNqC769g=;
 b=bwzTb2XMcreQOax2/0O/HwXsekmbepjUj2T8rIpw0LKtxeI4mfTt2tgFjY47Wlp6F7E9vg/He7TTgOFRwY6dLrbuqrgOnT3LQ86eUwRIeMrwJP+g/ZMsbD69NVlDH8gSxKWS4JoxKUm8MOaK7Gs0Ac7gXv6mKmbvFpUKHB1MTA52BRVIOv/gqdXUnqKvKDGWPk1PGLbhoc1GkCVADfVzQuWTvrTNUCeroQ/7DaCMywekXsg6o3lPqqblD+ikX48b7ZKm6hGrG0TLnLND/9cTqLNC0XfviAXK6tgfDwqLuwYLVm6nwQLhpLDEXWVIomuhZmuk/lpEtyW3nqJCF0rkOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ2PR11MB8585.namprd11.prod.outlook.com (2603:10b6:a03:56b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Wed, 24 Sep
 2025 20:54:18 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%2]) with mapi id 15.20.9160.008; Wed, 24 Sep 2025
 20:54:18 +0000
From: <dan.j.williams@intel.com>
Date: Wed, 24 Sep 2025 13:54:14 -0700
To: Tzung-Bi Shih <tzungbi@kernel.org>, Benson Leung <bleung@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki"
	<rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>
CC: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, "Dawid
 Niedzwiecki" <dawidn@google.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <chrome-platform@lists.linux.dev>,
	<linux-kselftest@vger.kernel.org>, <tzungbi@kernel.org>, Laurent Pinchart
	<laurent.pinchart@ideasonboard.com>, Bartosz Golaszewski <brgl@bgdev.pl>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Message-ID: <68d45a76a36ad_1c79100a6@dwillia2-mobl4.notmuch>
In-Reply-To: <20250923075302.591026-6-tzungbi@kernel.org>
References: <20250923075302.591026-1-tzungbi@kernel.org>
 <20250923075302.591026-6-tzungbi@kernel.org>
Subject: Re: [PATCH v4 5/7] revocable: Add fops replacement
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR2101CA0020.namprd21.prod.outlook.com
 (2603:10b6:302:1::33) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ2PR11MB8585:EE_
X-MS-Office365-Filtering-Correlation-Id: c4b2dd11-bbd1-4d7f-830b-08ddfbac8750
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eS9HdkNQRWIwUEVnSXR2L2xiSEFnNTJ4QnNhQU80NnZPMXJPcTFyd0FEcWxz?=
 =?utf-8?B?cnpQaHRXakxoVFNRRy9CZEpDVmJGQW1hdk4ySW14Zmg5eGRjeWxLQk5xY1hQ?=
 =?utf-8?B?dENNNW5NNi9tWVZvcFl5dEFmOUNQUTRHTkk4ZFVZbDBDZXFWTVZMc3VDd2ls?=
 =?utf-8?B?d1FLRWxvRENDeW1aMDhlZzliOHVsbWNjd0tkV3NSTFM1THduS1pGVVlXcHFW?=
 =?utf-8?B?VDFydXZ0c3VJUFpWaTBZalBEY0twcENnQ2pDYzJaRmV5bWdKNzFCL1NRUkxl?=
 =?utf-8?B?V1VOd2FnUEkrZmdLNFFaS1FaRXhoSm1XODdHT1h2SElFY01neXVwanl1cXM5?=
 =?utf-8?B?V1IwaDFUMVBPdGNrRlZ4MGtydE0yL1JoTms2RW5uMVdmVHpPb3o4cGpDZlZU?=
 =?utf-8?B?U3BhRVRkVXNvL2l4QTdGVFVGVnZsUkVBQUUzM3V5blRib2JhcUxuck15S01U?=
 =?utf-8?B?VjNTZjg2akFqYzRwaXk4NGViNmlOUGFhb0tQdlFNTDdTcklFN3AxNlJoNURp?=
 =?utf-8?B?UGdVUkFiRHlZTEVQSENWb1lXV3k5OHBEQnRwVkQ1Q0xsdWd6UWtrNW1FVnVX?=
 =?utf-8?B?bU43ZHdBUEVJRUFCNmJuVElJeVIzTVpQcjVrUUIzVkxJQTJQc0h5YnBCV0Vm?=
 =?utf-8?B?K3pPc0w3N1ZrM0dRQ05UUkNkeFlpdWtwNStLaG5GZW16VTFJUGZlT3Y3Z0NH?=
 =?utf-8?B?aU9MTkMvTGJZQ1FsNE1qamZMZDZDcTlqcHM5RlhqbHVibE5sbDFQcFZsNG4z?=
 =?utf-8?B?RXVZR3pYbThWZFArYmxFQnZ0cW0vT1BZcFg5VVN5MnUwN3pVTUhCWVBGWFNq?=
 =?utf-8?B?aUJIUVF2S1FKNHVlWUJBTUZoRktMcWVORGdjWU1UdlJ2V2loZ29WVGhVREFw?=
 =?utf-8?B?QXB0L0g5SzVCc3VWbTFMVGNWb3BWV29UdlJIcnFOUjkyRUxldGZpbmlOaEdN?=
 =?utf-8?B?NWRkcGg5ZzVEeSszRTc4V0hzS1ViNkpJN2xBL2VpRzJUa2o3aVl1MXRwbklX?=
 =?utf-8?B?WnVFRG8rQkI0V2xMTUliaW5jdzNxRFBwb2xpK1JFSkRlVkpVWTZ0RC9vS2lR?=
 =?utf-8?B?Y1NrV1FxcEJ3WGgrQUZxNGZtRXVtd21YZXRRWm5Pd2E2VEpURk0rWGtTYVdK?=
 =?utf-8?B?NFZaaGFDcC80R080M3BCTEFBeldzKzIwZmNEMlU2VWRva2tlQ2tyOXJreE40?=
 =?utf-8?B?KzRLMW91TG9iOEJ2TFpaa21lNjhrc0h3Q2ZrVDdJKzY3SzVKeWJQdVgyUzV3?=
 =?utf-8?B?ZHhHcm9ueFE3dnUyZ2dYVWY3eFg0MHdIN1l3eTFlQU0rZkp6YjVCb2tLOEc4?=
 =?utf-8?B?akRpODUwQzM5ZmtHV3NCNVorM3JocHVvYXhNM001aXBCNTFJb2VvU05WTy9x?=
 =?utf-8?B?NFFvNUN0WEpPeG1iZGxXWlNvRm96R1EzNE1WODd1VnlXM1dMWHdSd1Vrd0RU?=
 =?utf-8?B?MWt3N0lTanZJSWVRT3JPRnZHY3BQTnFTMnhBeVhPbGptWUdVUG81UHpLQ3ZM?=
 =?utf-8?B?emdFRzVZdzJVaW5zT1VCeGpKYUtZbmxkR3dZSnp3bTRiZFdrQjlUajhPWnYy?=
 =?utf-8?B?bVBtL3NVNFQvdEgzNHNLMGMrNU5XRkl4a2Y3NUNMeTkrdXI2dmlEYUFvaWpu?=
 =?utf-8?B?QktaeFdNVU4vRVFjRTNMcSsxU3RHVTVPOGRFQlhMcEJNeTdKVDFBekZVaXlr?=
 =?utf-8?B?cnpGaXFkVUkxVnNTVDNseXRpVVZ0eno1UlRweHlNbTMwZUtNcHF3NjM3Yk5q?=
 =?utf-8?B?by9ROTJrOGkySG1KeGpRdmsxKzZTQTZ5ZDluclIzQ3d4WmhFQm5FK2ljRzRC?=
 =?utf-8?B?eVV2UkoydFMzYnB2aVlXRHFyNDNvanFxN3RhQ2VoQ01JWWRwYTJQS0NWVVpw?=
 =?utf-8?B?OFhEREZXc0JCQjAyYS9VMjllMW1aYmIvUFlvTTV4TEJWWEFyeHVaM2cxVnVu?=
 =?utf-8?Q?fjQA02dwloI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RkVjZnZ0cldxNVlzTU5nbGkxam04ZUpoeUpqZ1MxSEFKa2lrYklqdUlIaUFO?=
 =?utf-8?B?eHBra0ljZGZ2bVprdTBHcVozUEx5bDlDd0FDT2NhbEJPeE1UWW9oU1hxZERv?=
 =?utf-8?B?Zm5iUnM2cXBPY3kzRUttWUFqTmVxV3BDQVNpSFhaWWFOd0t2ZWNlT2xVTVZU?=
 =?utf-8?B?MmJFa3ZwckJnOSsrekFVV1E5amlkcnRnamltak9rb1JMQnp5VkVrdjlSUjBY?=
 =?utf-8?B?ZUU2UEg2b2ZVTkFPRFFnL2hoTHYxbEkwQkxnanhDRUJBbE5aQng1M1lnUE9D?=
 =?utf-8?B?UThxM25HaWJKdDRHZ0t0K3p0dDZCNGplZ3JWT2s5ZE9UUVRMcFh6TGx2eWlt?=
 =?utf-8?B?QUxGZVVWZzhOZXNnZEJnYk1SZi9pY0N2VUJISUJvRXd5UDc5K1I0K09NVVlQ?=
 =?utf-8?B?WmRoenVLR1llWWF3eUlGNEpxT2kwdFNIa3F0cHpQVlNUcFQ2MGF6ME9pckxp?=
 =?utf-8?B?VE9URit0c29sK2VSTk9TN2wrSm5rRnI3MXZRV2VyYmZYakVFdmlNQmx4alFJ?=
 =?utf-8?B?RzV6SVdDUmxSV1RTOEpqc3RRemd4eCtkN3A1d1lheEVnOGh3Uld5L2FuY0Q3?=
 =?utf-8?B?dlNkcW9NcExlNEdhaWVNNUxEZ1ZmeldIVldNd240ekF3TFlDeTh1NGNxNjNt?=
 =?utf-8?B?N21sTGJlUzFQd3ZleVpPRnJxcFVOYlkwMEg3Mmh1c25MOXdrdElub2txM0ZO?=
 =?utf-8?B?MlFIL1ZhZ1B5V1N5MlBLbitOSDZudGJXOGJnVXMrd2daQy9QVHdZTjNZQ2ZM?=
 =?utf-8?B?K1JEWDQrNFUyNitlUEpGMDV0a1gxejFyeVQ5ZU1UbDBpSTloS1B3Nkh1ZEV2?=
 =?utf-8?B?SHpqTGtSdzJjSHNEZzVpd28vKzU5RVZJNnViWlg4MlNaQzJmS2xLcFVNYVJX?=
 =?utf-8?B?cEtoRlZUVjV2SG5TSGduUmhvR3VoYm81Y2dpcE1TZHRMdWFaSDd2L3JuZm9a?=
 =?utf-8?B?bU1hc0ZNUS9xWTJHMXBOTzVWcE8rUGZtTWJ2L2FiVTNBa0JLdVo0QktUWDgx?=
 =?utf-8?B?U21FTWV4ZkpXYXEzS0dGSjdldy91K2tkUWVWSlI5L3hISGw3L0ZFSk5GRHV5?=
 =?utf-8?B?RTdPdnVaVFRicUFGUmZzeWc4c1VaWDZMaFBsdmZPVzZjSnBKa2FyMXdWeTJp?=
 =?utf-8?B?RzRKdVd3a1V4VTRIbzRkNWt6aEkxTnJqeS9kSlFZUUJsT2hUU0dQWFNqZlcz?=
 =?utf-8?B?ZG1BTDB6YnVIMjJScEFwOFZMdGJ1RG15cjVmbHUxYnBKbUdVM2E4K0FxRms0?=
 =?utf-8?B?eGtjTXB2L3dtMXoyVGtpaURIajR3T2dudTBHZjlOMXpzVHN6TFpsb2JnNWJP?=
 =?utf-8?B?QWtRRm4wWWViOFg4cktOTFV6b3pQUHo1SzhtRUZ5cnNHRElhSGQ2Wk9lL1Rl?=
 =?utf-8?B?Wk50TTg2WWVPSldMaDVsY0pGZ3Bmd0tMQURiZ3ZINGdTMTEvVXo1MDEwT3hk?=
 =?utf-8?B?bTZKVTBZTkJVTGpaSUorcFZOTTdla0VSaVpTSXFLQzN1dXZvRHhkeE9pNWsy?=
 =?utf-8?B?ME5SK01BcWNsL2VVTnRISTc5NlhqYmF1MEJhVG1aQUVldGVMV1NBSmZJeVJR?=
 =?utf-8?B?K082UjZjTCtjanpFaVdkMGFPazhKQ2hkMUNia2FDOEs5MzhkOE4zWkh3NDhp?=
 =?utf-8?B?M05YbzQ0cTZrb2tCeDBVNjhKdzBQNURUclcyVldTejJnNHVCQWQ0ZzBwQ2lx?=
 =?utf-8?B?QWwzZjRSS3pBZ2FOUHZLZFJXbFFkRG1raFd5d0tXOUJWWHhtQ1NhZmduTCtj?=
 =?utf-8?B?elI0bTVCRzJzbFpab0w0T2RIb3NjQUU3YjNwM1Bsd1lLK3drVzNDVUc2VTd4?=
 =?utf-8?B?eDk0Nk9LWjJsUkYwdUVGelRoeGVnZlBIZTRZSk5GR1V0MFZ1YTJKUlFjeTNT?=
 =?utf-8?B?VVduSW9VeGV0NkxpWnVoZTM0VWtuL3l2c1B3RFF0dXFRNURmZWFNZWs3OU0v?=
 =?utf-8?B?RW1TRTVzSVBieHhjZER0Ry9PakM3R2JmN2oveWozdGw0Y2FZdXlITTRSUGtl?=
 =?utf-8?B?VWpjMG1xT0ZzU1VRTk1RK3ZXMWJvUXhGajdYVlViSmo0OU9BUGlrb1M2RTFy?=
 =?utf-8?B?SUxYbXRpQ21LdmFkUFRLb3FWU0t4ZEpEWWUrQXhqTDBhRVQwcW01TlF2U2dt?=
 =?utf-8?B?Zk5CUzdJK1RPeWx2T3FBemYwNEZGREUwak5EWktOTXFHdy82TlFBUDFLTzR4?=
 =?utf-8?B?eXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c4b2dd11-bbd1-4d7f-830b-08ddfbac8750
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 20:54:18.1561
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gMhekfPat+w7/Nv/RbnZg6prG3mbmlpgVuPBcRNR6jJ2A4tVedokjumrK6o9rqPgK54V7BMxkNUeaKG7m8ENwd9Z+eystLp1g+afnJjwVeQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8585
X-OriginatorOrg: intel.com

Tzung-Bi Shih wrote:
> Introduce revocable_replace_fops() to simplify the use of the revocable
> API with file_operations.
> 
> The function, should be called from a driver's ->open(), replaces the
> fops with a wrapper that automatically handles the `try_access` and
> `withdraw_access`.
> 
> When the file is closed, the wrapper's ->release() restores the original
> fops and cleanups.  This centralizes the revocable logic, making drivers
> cleaner and easier to maintain.
> 
> Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
[..]
> +/**
> + * revocable_replace_fops() - Replace the file operations to be revocable-aware.
> + *
> + * Should be used only from ->open() instances.
> + */
> +int revocable_replace_fops(struct file *filp, struct revocable_provider *rp,
> +			   const struct revocable_operations *rops)
> +{
> +	struct fops_replacement *fr;
> +
> +	fr = kzalloc(sizeof(*fr), GFP_KERNEL);
> +	if (!fr)
> +		return -ENOMEM;
> +
> +	fr->filp = filp;
> +	fr->rops = rops;
> +	fr->orig_fops = filp->f_op;
> +	fr->rev = revocable_alloc(rp);
> +	if (!fr->rev)
> +		return -ENOMEM;
> +	memcpy(&fr->fops, filp->f_op, sizeof(struct file_operations));
> +	scoped_guard(mutex, &fops_replacement_mutex)
> +		list_add(&fr->list, &fops_replacement_list);

This list grows for every active instance? Unless I am misreading, that
looks like a scaling burden that the simple approach below does not
have.

> +	fr->fops.release = revocable_fr_release;
> +
> +	if (filp->f_op->read)
> +		fr->fops.read = revocable_fr_read;
> +	if (filp->f_op->poll)
> +		fr->fops.poll = revocable_fr_poll;
> +	if (filp->f_op->unlocked_ioctl)
> +		fr->fops.unlocked_ioctl = revocable_fr_unlocked_ioctl;
> +
> +	filp->f_op = &fr->fops;
> +	return 0;
> +}

This facility is protecting the wrong resource, and I argue hides bugs
in drivers that think they need this. That matches the conclusion I came
to with my "managed_fops" attempt.

The resource that is being revoked is the device's attachment to its
driver. Whether that is dev_get_drvdata() or some other device-to-data
lookup, that is the resource that gets removed, not the fops themselves.
The only resource race with fops is whether the code text section
remains available while the fops are registered, but that lifetime scope
is not at a per-device instance scope.

revocable() could be useful for more complicated scenarios, but for
making sure that ->unlocked_ioctl(), ->poll(), and ->read() start
reliably failing, just do:

    guard(rwsem_read)(&subsystem_device_registration_lock);
    data = subsystem_lookup_device_relative_data(...)
    if (data)
        return subsystem_{ioctl,poll,read}(data, ...);
    return -ENXIO;

...and revoke future subsystem_{ioctl,poll,read}() invocations by making
subsystem_lookup_device_relative_data() start failing under
guard(rwsem_write)(&subsystem_device_registration_lock).

