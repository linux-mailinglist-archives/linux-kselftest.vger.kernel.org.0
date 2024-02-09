Return-Path: <linux-kselftest+bounces-4471-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7887284FD6D
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Feb 2024 21:18:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8CB2B27369
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Feb 2024 20:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C21F986ADE;
	Fri,  9 Feb 2024 20:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eHkBqi72"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DAA280BFA;
	Fri,  9 Feb 2024 20:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707509898; cv=fail; b=F8AM9C3PRV7tnl+J8rhGCj12aFnhLVOq+j9TjNaFSqAVMJYqNZ49BXgBoKW1zgsvopWHqxTvBtCGqQkATcz0Acy4M1DHMHGqUBLbU6K5+hAuE7i0aCrrMwKzvJo48yqt6+d1ZUtPZ3Zv2JDhJ+x1ktQYXhbwX6IEMnhAKQu2MV4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707509898; c=relaxed/simple;
	bh=XS9s/R1vTRhTipIHBF4Uwz86NwvyVVbtJOjQ1qYgR2E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JlSLnfYg3r26IXyqzqz2MuaUBXw3O5A88W9iJfUsVwQLNE+lXLAu4Q/c8EyxjxjgAAnzjaEf/rsNG+i2oi66R0EHqL05EMo6P0fvsR3LDKoX13GYlWy6n8MIHP1baMkGI5zY17Lz2QSTDYRg0oLdpK7N1fMa9RthLUzBdwmYz9w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eHkBqi72; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707509897; x=1739045897;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=XS9s/R1vTRhTipIHBF4Uwz86NwvyVVbtJOjQ1qYgR2E=;
  b=eHkBqi72wgV8ETVG6l1TPXeKtUYr/XadhhYpNoSo4uli7n7gpq2mmIsG
   yP9nov7jBzO+aeFZLy7xd892yu8bGoPPmHmNtD9MqOUaFXaYdhE/rkc0v
   PnKjRnaEh79wRqc2NtfNMfkAK87zOUYGnTV45xAzzkUKVj7nJZApzJHsu
   hHkSgijgLLEi5QUXNqWliHZwxk5NvmtBS68JVZt2FNwHIe70WcWM2CsPK
   0uwJJ0WTchCnsHsGhNREjoS3uQMlOZ97qN7t6XHrTWxjRR7Kmf7MTyexK
   +/HNXl8GGPI9Bm79QOZqMXGdsjFWCsW0dboRakVTriYtv3bPk9uzVTITt
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10979"; a="1374228"
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="1374228"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 12:18:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10979"; a="910809959"
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="910809959"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Feb 2024 12:18:14 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 9 Feb 2024 12:18:14 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 9 Feb 2024 12:18:14 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 9 Feb 2024 12:18:14 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 9 Feb 2024 12:18:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V5QJRfic0JllRHdAdFdVu/2s6ekDjG3hMOPv4/sK+0yQSqDiuqDpZV8mbYQ0jrXHC8o3/hp6xxxNmdPy0KEYGyw4X8wDLg3eMniFD0fWMeKdM8x+tXB34+irh3pItA0+umghBBkqsQ1lSUh/Fxq9T0NwREXbXnFe4wC/LX3yKp5bIagtekIJsNcN8lxHB3bnnGsfWeKLeahRVkmjzEWlosSfKifXVF6FhTCnPXjJuar3Gj/QeOKOiCnpRNrdu9JPQuaytz1F6oSvU8RSV9D1thBRdQkVxIljrJ9Vqxwqu+qReQfA1henyXGbyQ7TxKXABIbEsDCBaMZd1F4S1eBJ6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XS9s/R1vTRhTipIHBF4Uwz86NwvyVVbtJOjQ1qYgR2E=;
 b=JV048uqMpUyCfLUEaApJCugu4v8FdDw9Afgwrn0dCCzNvJtW5pliYYq7ILnVvsfBWLIyTNv0b/CtAc41jyN1uHXJyUc1XkKwZ86vfnWi+4Y9zGEjhFSlCSiHwTex86W0TUmptxNVObsYHybOe266WaFi/1uBgtxJDDc9/vGWQGXSyatqqe5WjvoXVk0SYxJrVKoXleAN41AOzUf567EAr+1hr/jYR0YtFaNLGr/7eBGNvcA+FlsusUUi1MfTFoNgvFoDMkKjskXSRHxJ2//VZtmoHSm8t7AirAWyuEmgai7mRNxpAv5zrTtYK517wOj1Jn8AGaIw88Gl0L2XIX0Yvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by PH0PR11MB4808.namprd11.prod.outlook.com (2603:10b6:510:39::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.24; Fri, 9 Feb
 2024 20:18:12 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::5d40:83fd:94ac:d409]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::5d40:83fd:94ac:d409%7]) with mapi id 15.20.7249.035; Fri, 9 Feb 2024
 20:18:12 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
	"broonie@kernel.org" <broonie@kernel.org>, "Szabolcs.Nagy@arm.com"
	<Szabolcs.Nagy@arm.com>, "brauner@kernel.org" <brauner@kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"debug@rivosinc.com" <debug@rivosinc.com>, "mgorman@suse.de"
	<mgorman@suse.de>, "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
	"fweimer@redhat.com" <fweimer@redhat.com>, "mingo@redhat.com"
	<mingo@redhat.com>, "rostedt@goodmis.org" <rostedt@goodmis.org>,
	"hjl.tools@gmail.com" <hjl.tools@gmail.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "vschneid@redhat.com" <vschneid@redhat.com>,
	"shuah@kernel.org" <shuah@kernel.org>, "bristot@redhat.com"
	<bristot@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>, "peterz@infradead.org"
	<peterz@infradead.org>, "bp@alien8.de" <bp@alien8.de>, "bsegall@google.com"
	<bsegall@google.com>, "x86@kernel.org" <x86@kernel.org>,
	"juri.lelli@redhat.com" <juri.lelli@redhat.com>
CC: "keescook@chromium.org" <keescook@chromium.org>, "jannh@google.com"
	<jannh@google.com>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "catalin.marinas@arm.com"
	<catalin.marinas@arm.com>, "linux-api@vger.kernel.org"
	<linux-api@vger.kernel.org>, "will@kernel.org" <will@kernel.org>
Subject: Re: [PATCH RFT v5 4/7] fork: Add shadow stack support to clone3()
Thread-Topic: [PATCH RFT v5 4/7] fork: Add shadow stack support to clone3()
Thread-Index: AQHaVjTM4mh9/kTPoUSvLm4ofHC7c7ECfcqA
Date: Fri, 9 Feb 2024 20:18:11 +0000
Message-ID: <565ca9697cf26be5509ef4b3c1cc95fa4f692b9f.camel@intel.com>
References: <20240203-clone3-shadow-stack-v5-0-322c69598e4b@kernel.org>
	 <20240203-clone3-shadow-stack-v5-4-322c69598e4b@kernel.org>
In-Reply-To: <20240203-clone3-shadow-stack-v5-4-322c69598e4b@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|PH0PR11MB4808:EE_
x-ms-office365-filtering-correlation-id: a73f189a-13c4-4a3d-2f3b-08dc29ac3d58
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: h3VPZ8c0eOc9X9eePF8mI1pUv/EmivE2U6Kr5nDIv4f5ogB9LqEHrxjxpRQWY+NgObCbA/TF17YdFM5QTQkoUg5oJkwo6IkEJNvNaYn+c9j6ERPswoNrZuQsogJ4wte9pXyUWP67UahUqx8jq5de3WiomAf/F9IR/S75g7izsKkcMGP7J/5BF7+/wyN/r6D++Uyi1CDYm4oJc2TJkS5CfkZ0z+IgqRwiJLS+JTQ8Yo/0TQTaesS8HX3Ha+wvYnhI+g6LAy8rAbCfIZgC0ZLeZCXb48UfbzwEZrv3wX4Uh/6oYz8OyiPC5EI83b0ULD5W6W33CDtZTb0Pt2HH3M0U3BvozLGY4V8Aaj8G+DFUuw6w7ZwlrODCUnRNAXKp1wAg+E2f8ORfzEOvo95fr8CpkcRTgAXIkRsUvAX9x1vD30KcymRKu8qezdlOI/ULCTkXVKTYotyXWlsp4/mCoW+RHyudgaMdT+vzDgBK/qJCmaj7KoSVYc3DBljkrus2LO/nuUKgNsEkaGovmYpbVbq2d/LvLGei3Kyl+eqH7O2mAjEGm9FDwVBbTsdNlafvfJL8r6L5X2L9i/ainwqQKVImaCNy4O3shV+k4dLnFjOuTVgb4BbrxxFPYDYjmKUcGXcD0qvypVNbWCs4T2p9oQytuw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(366004)(39860400002)(396003)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(921011)(38070700009)(36756003)(316002)(54906003)(6512007)(4326008)(71200400001)(478600001)(66476007)(66446008)(2906002)(6506007)(64756008)(76116006)(66946007)(5660300002)(7416002)(6486002)(82960400001)(122000001)(110136005)(86362001)(38100700002)(66556008)(8676002)(2616005)(8936002)(26005)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N21uSUE2UHJUcks3ZGRrTU5QUGx1NG9ZeUtrVENOdG9JRUNVL2JTL2E1RCsv?=
 =?utf-8?B?NytrdkZSanVsM0M2MHRjcTBRa1JGWXh3eWl5RXJHek9pK0Z6dXg3bVZINXF3?=
 =?utf-8?B?MlFreCs3MERxdGhkUm94NnczQWtnbWhFSWtjZW03QUZlek9EVFJzUk01WFdH?=
 =?utf-8?B?Y0FQL2xBL25jWHdmbzhoWVVCUWp1SlhCOGVzK0RsYXNUbVJCTTJMOVFqRlpR?=
 =?utf-8?B?T2Z0dlNBZ3BCaWdPWC81am4rU3VIdGQ0d1RCaXYwMDBpN3FnWWl6R2JmM1lW?=
 =?utf-8?B?RlI0YkJxdnIwdUpUR0NpQjFDUmZKZExrbUdTSFM1MUI0U24xQ0lGRVpvSTZh?=
 =?utf-8?B?Q3NUaXF1T2ZqajZ5Q3RjOVBITU00NTdDUXBlR2xWU0lFVjB0VmgweVUxS1pi?=
 =?utf-8?B?bEZlT3RHSkpGOFhUSUhWL1pGQ3l6T0syOFlvOUZ0bnhydmdXdGtUMklxUEhv?=
 =?utf-8?B?UDhkNXZzSm1neVRWOExNVjRESGlPUnJIOTVyVXkvQnMzU0p4dCsyUnFwejZW?=
 =?utf-8?B?ejFxVWtmeEJvMWFOdHZBengwV1NWU1A0MVFFL0ttTU1kNlNUS3IvdHhHVWhR?=
 =?utf-8?B?aHQvbkhwUWxmV05Bd2htT2ZLRWE5TW9JTktQR3pxTW1Na3FWc3lTL1JmaENk?=
 =?utf-8?B?eW9yb2tpMDRmK1lRWklkQ0s5Vm1oc0tPSzQrNGo5eFdmdkN4cWhQMlRmSE9F?=
 =?utf-8?B?L0FEelBYbkFCeVliMU1nTk9nWXBhUjl6eW1ISTVCcWZqRmpFb0ZETzVFc1ZY?=
 =?utf-8?B?YkUxOFd3UXZwdDZXM0VCRTNYMmM0MEZRSDZHa1J3WlE3dWhNV1h3cWFkcytN?=
 =?utf-8?B?U3NrUFBMT1lYYWdjRHQ3bGZhVC9TSTZzTFhVZndrS3F6aURDbEIxRVo0K0ZU?=
 =?utf-8?B?T3hRcTNPMTB1Q2E2b2RZQjZhemxXdnFZb1V4S3h1b256eTA5dnNReG1NdXVD?=
 =?utf-8?B?M1J3ZjR4VmM3WVZZWHQ3ck9zdkdLcDlhaHR4NWpWNmdaZUtWaFZnaDhIaW5Y?=
 =?utf-8?B?MXh6blp0SHI3QTNacXMzQ0Y3akc0Y0ZDamVDL3hpWnhiNU9xd3JkMmpmaFZY?=
 =?utf-8?B?RjU5YnBZMG5nTHZrU2Fxd0F4K3dQWkJYT1drakpWeS8yb1R3dGVUQzJuT0Yv?=
 =?utf-8?B?ZXZRMCswN3A2M0I5NmxZSTZtRkhYcjB1RXUxTUIwQmh2Q0NhUXozajlyWXp3?=
 =?utf-8?B?bzY3b25pRHBrM25NcVgybmZZZnVEa2VlbkxVOWRqRHZuZU11SnUwZGpVZWky?=
 =?utf-8?B?d1B3TmtLMTF3VWlHNHRFeWFjZHZLbzlWUTZLTk5sUXo4cXN3YWZzY24xYVFq?=
 =?utf-8?B?OHV4YUxSTVMxNjhmQVcybHJWTmRzOFMvaWUyaW1tYVJOTzlWeTlWVUFmUlJs?=
 =?utf-8?B?eWV2NHdKZ1hUR2dsSFpEeCtod1BqNnVCLzY4WURPUXJMcGFQSzRpMmxzUGNv?=
 =?utf-8?B?YUhhVmxaRWg0VkNvamxET1V1WTN5aTU0RjA4dmdmNkgxOVNZb3N4K1VoaEEr?=
 =?utf-8?B?RVN6bitsR1YwN2kzMjlFS0tKS09qeXNObTdZQlFjR3Q0TTBrRk1DUmpWTVJx?=
 =?utf-8?B?anQyUWtmMmhjWGRiSkVsdDdPVW8wSU4vQUEvZTFVbjcrd1lQWHVGVzFaajhV?=
 =?utf-8?B?U2hWSEw0YURVNkI2MzFlb3FPTnpSV0UyUHJmZlJoWWwrOE9ZTzVBVHhZTkRM?=
 =?utf-8?B?NlMzcTdaTHFCSHZoSEgwREpYNFpxZXkxdnhGbmp2QThrbkQ1WElRT2lLYTZo?=
 =?utf-8?B?QUNiTUFLWUJyaU9DRnd1WUc0clYydWYvUUtJTVIyZ09qcWl5TzZITWphZFBL?=
 =?utf-8?B?ZjZiQytiakxSYUw3MFhoN1Q2UlUrRFRZZXEvaGhhZWtMVmRXamNPRytGdTBz?=
 =?utf-8?B?dXB0cnBpc2xVT2lBY3ZJNkpTdmUzTnptMlJUVXlxZXVtVlJ2bHVFKzVzYnFa?=
 =?utf-8?B?Qnl3NjdXMStkREJuanIzYVBKWVFXRHpkaUJScEVCSlR1ajAyTGw0eFRCendp?=
 =?utf-8?B?cUNxYmI0S3lqRDNkK29RU21HZGVZNFBxVDRkckpjbEJLK2xsemNuT3lWMVky?=
 =?utf-8?B?WmNGK0tpVnhRRnVoeVgxWUdraENkdGJya3ZKN09pS0k5MEE1REU0aXVKbzNt?=
 =?utf-8?B?cnR6ZmRJRm5qWnBsMUpWTE1tckxzbXpaNUV6NnBZbmMxRDdGeUl0VTRMN2E1?=
 =?utf-8?B?RkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <ED7AC54E745FCE46BD9EB576DB57DADA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a73f189a-13c4-4a3d-2f3b-08dc29ac3d58
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2024 20:18:11.9581
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: di0YTgd9CElnTDrGEP25NmVvdwp83FUHN2rUP1gN41+FeI3on/Ld6TxwnEgPjc5fbkw6LiTHF8pFu72pwPjUJ3FZOmCfFxNcfQqgd//TeMs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4808
X-OriginatorOrg: intel.com

T24gU2F0LCAyMDI0LTAyLTAzIGF0IDAwOjA1ICswMDAwLCBNYXJrIEJyb3duIHdyb3RlOgo+ICtz
dGF0aWMgYm9vbCBzaHN0a19jb25zdW1lX3Rva2VuKHN0cnVjdCB0YXNrX3N0cnVjdCAqdHNrLAo+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoHVuc2lnbmVkIGxvbmcgYWRkcikKPiArewo+ICvCoMKgwqDCoMKgwqDCoC8qCj4gK8Kg
wqDCoMKgwqDCoMKgICogU1NQIGlzIGFsaWduZWQsIHNvIHJlc2VydmVkIGJpdHMgYW5kIG1vZGUg
Yml0IGFyZSBhIHplcm8sCj4ganVzdCBtYXJrCj4gK8KgwqDCoMKgwqDCoMKgICogdGhlIHRva2Vu
IDY0LWJpdC4KPiArwqDCoMKgwqDCoMKgwqAgKi8KPiArwqDCoMKgwqDCoMKgwqB1NjQgZXhwZWN0
ZWQgPSAoYWRkciAtIFNTX0ZSQU1FX1NJWkUpIHwgQklUKDApOwo+ICvCoMKgwqDCoMKgwqDCoHU2
NCB2YWw7Cj4gKwo+ICvCoMKgwqDCoMKgwqDCoC8qIFRoaXMgc2hvdWxkIHJlYWxseSBiZSBhbiBh
dG9taWMgY3BteGNoZy7CoCBJdCBpcyBub3QuICovCj4gK8KgwqDCoMKgwqDCoMKgX19nZXRfdXNl
cih2YWwsIChfX3VzZXIgdTY0ICopYWRkcik7Cj4gK8KgwqDCoMKgwqDCoMKgaWYgKHZhbCAhPSBl
eHBlY3RlZCkKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIGZhbHNlOwo+
ICsKPiArwqDCoMKgwqDCoMKgwqBpZiAod3JpdGVfdXNlcl9zaHN0a182NCgodTY0IF9fdXNlciAq
KWFkZHIsIDApKQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gZmFsc2U7
Cj4gKwo+ICvCoMKgwqDCoMKgwqDCoHJldHVybiB0cnVlOwo+ICt9CgpTbywgZG9uJ3Qgd2Ugd2Fu
dCB0byBjb25zdW1lIHRoZSB0b2tlbiBvbiB0aGUgKm5ldyogdGFzaydzIE1NLCB3aGljaAp3YXMg
YWxyZWFkeSBkdXBsaWNhdGVkIGJ1dCBzdGlsbCB1bm1hcHBlZD8gSW4gd2hpY2ggY2FzZSBJIHRo
aW5rIHRoZQpvdGhlciBhcmNoJ3Mgd291bGQgbmVlZCB0byBHVVAgcmVnYXJkbGVzcyBvZiB0aGUg
ZXhpc3RlbmNlIG9mIHNoYWRvdwpzdGFjayBhdG9taWMgb3BzLgoKSWYgc28sIG15IHF1ZXN0aW9u
IGlzLCBjYW4gd2UgR1VQIG9uIHRoZSBuZXcgTU0gYXQgdGhpcyBwb2ludD8gVGhlcmUgaXMKYSBs
b3QgZ29pbmcgaW4gY29weV9wcm9jZXNzKCkuIE15IGZpcnN0IHN1c3BpY2lvbiBvZiBjb21wbGlj
YXRpb24gaXMKdGhlIHdvcmsgb24gdGhlIGNoaWxkIHRoYXQgaGFwcGVucyBpbiBjZ3JvdXBfcG9z
dF9mb3JrKCkuCgpJIHdvbmRlciBhYm91dCBhZGRpbmcgYSBzaHN0a19wb3N0X2ZvcmsoKSB0byBt
YWtlIGl0IGVhc2llciB0byB0aGluawphYm91dCBhbmQgbWFpbnRhaW4sIGV2ZW4gaWYgdGhlcmUg
YXJlIG5vIGlzc3VlcyB0b2RheS4K

