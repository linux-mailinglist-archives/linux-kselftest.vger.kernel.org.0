Return-Path: <linux-kselftest+bounces-28876-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DA15A5E908
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Mar 2025 01:41:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFC80189CA21
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Mar 2025 00:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 832D4C2D1;
	Thu, 13 Mar 2025 00:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kz78qPAY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFDC62E3395;
	Thu, 13 Mar 2025 00:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741826512; cv=fail; b=NEFQ6ghu3L3WNIjGOT7lhsd14NkGg4kvUO5BLK8RsnS5DB3cvb3eYRLm9QlIHg9hg3HHDQMayWSFB9NE0ZL10Mhnp7X0mZqv924TyWoAij74wxn/y2fjxfRqBPUixaM8JFzngrdV25v9l1vDvGcp1QfjH2WV23BVqcdO9iMsAkE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741826512; c=relaxed/simple;
	bh=T8/fATchDl9gZgddICmqgZ6MSpaXo/05Ad+nXyX4fZ0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nLkYBz60Tco4iJO48Ijq3iq7H/2wyh3XCggITYkxO2ICouzIDg9P4KF8joLUHAUIsM6TEJ2QTvrA4NwSlpArOjHeKeNiokDvsMNMJFVBvAx4xwSM7lceGDVlneMLoX/ZXWmv9yd1/6FvZ5XJ6UGUA6+jgxl7xU1ojMUmewfj6pw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kz78qPAY; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741826511; x=1773362511;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=T8/fATchDl9gZgddICmqgZ6MSpaXo/05Ad+nXyX4fZ0=;
  b=kz78qPAYxNCmvyDMFjwyRUSnJ8FHYDXRgYLbGqFxqGFV5MaFUGpP4lxV
   81VUk3vKurMum5SshdwFNiIbY0uM957JMSFPuaREqRIHkwFRfKFoOvuLJ
   UiTlbORqc0s54/0nfy0xVFZJBsh5LwTxY+6IPosXeQwUnh4s4F/agcDo0
   crGz4eBZkEzUYR8ZeAv1FGhm0C3MNzMDveqxntVrWnWSRPU9TGqd9e9nX
   x0eB9tm1YzyQG4UdPQgatrqSpqwx1IHvpE/7wGAlzpsSzdxqjSarW7zAZ
   1DExObOavRWPmz5dFgY2ys+Qu7VhKIz7XGK67GO4wHUBVbzQEUF4EG7gI
   Q==;
X-CSE-ConnectionGUID: h41XPe0oQWeX7KqBYa2b5w==
X-CSE-MsgGUID: 67gagb6tQk2ys/W1kQSZGQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="42837213"
X-IronPort-AV: E=Sophos;i="6.14,243,1736841600"; 
   d="scan'208";a="42837213"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 17:41:50 -0700
X-CSE-ConnectionGUID: mwpE2CtbShWIC5E0UOAXlw==
X-CSE-MsgGUID: O8JdwxHdTm+ShEffu2ZllQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,243,1736841600"; 
   d="scan'208";a="120756368"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 17:41:50 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 12 Mar 2025 17:41:49 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 12 Mar 2025 17:41:49 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 12 Mar 2025 17:41:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RNZpTOSucmp3n00Wm+A3RMD6WzAnvfv3Cv6feWl1RMsX3aXZB5Jv/NrHjpOjeRsAVvkKUjlpir2UcXH71+yLR6pSjT8UQuDe+BYMuyZRqQEPQX8d5SDLVgFM9JoHLJLwa/o5IjU0pncLXKKfJnZoFpgdRqF7ExGqzBjogWyj/75v3fMdIyFLrHVRdwB5D/lQir83jyiNTk8kYboxgWC9cOdKprDJYBGNDeKc8dNAhd/MTjd4zFdIMZEqc6EGeRIbrWFj1UhZFRTJcIjsayZJcUmWTXmMt3EWahwkQbIU43lOwOoXmZ8JAsSOZNIfVxtTO7sRvw68kLqHKPw9gO/EMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2dMIzgWgzrCGMipIaidTn9MJCiDppqxcdacIooIBtrc=;
 b=mzAnobnhi8hrt7bs0fB2Bk2tD9YkQS54Wy9f/vSLp0FzmamWQ8pBvhwkUHLOB7oVclYsQzcvO087h+20v6apC09ofHVKcGnl4MzcG8p9RIvoKBOc9adYQljnyPHQugk09Edh/Jc9KpjbfJ3PutyqmJCFtOD6J1L2HLHXukexis6fQxjJt+OLk6phm7JJ5d+POz98MiYaaEG67pndke84eY2axwNFPFj8d9nfrNY6fxv4wNnYXQJBqUPCUv7M9ptoTIRGUdXvXDGwAJOhVr5SKqI6Mh/gLJK4UvtUymHknc0lNQ2o/uywjo5HDut82qQG9rutjolMsIINkQo0mM9qIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5423.namprd11.prod.outlook.com (2603:10b6:5:39b::20)
 by DM6PR11MB4625.namprd11.prod.outlook.com (2603:10b6:5:2a8::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Thu, 13 Mar
 2025 00:41:05 +0000
Received: from DM4PR11MB5423.namprd11.prod.outlook.com
 ([fe80::dffa:e0c8:dbf1:c82e]) by DM4PR11MB5423.namprd11.prod.outlook.com
 ([fe80::dffa:e0c8:dbf1:c82e%6]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 00:41:05 +0000
Date: Thu, 13 Mar 2025 08:40:50 +0800
From: Philip Li <philip.li@intel.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
CC: Tamir Duberstein <tamird@gmail.com>, kernel test robot <lkp@intel.com>,
	Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor
	<nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, Miguel Ojeda
	<ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng
	<boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	"=?iso-8859-1?Q?Bj=F6rn?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin
	<benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, Alice
 Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo
 Krummrich <dakr@kernel.org>, "Greg Kroah-Hartman"
	<gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>,
	Rae Moar <rmoar@google.com>, Bjorn Helgaas <helgaas@kernel.org>,
	<oe-kbuild-all@lists.linux.dev>, <linux-kbuild@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>,
	<linux-pci@vger.kernel.org>
Subject: Re: [PATCH] rust: enable `clippy::ptr_as_ptr` lint
Message-ID: <Z9Ipko8DBD2cz1nF@rli9-mobl>
References: <20250307-ptr-as-ptr-v1-1-582d06514c98@gmail.com>
 <202503120332.YTCpFEvv-lkp@intel.com>
 <CAJ-ks9mkbs9KG5D5yETvOJfeqyzTts1gVZyNAogbxjXbwOreZg@mail.gmail.com>
 <CANiq72n2cYvAWkz+QwG9++NknaN-A2g=N4AeatADwRZ1pWtk0A@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72n2cYvAWkz+QwG9++NknaN-A2g=N4AeatADwRZ1pWtk0A@mail.gmail.com>
X-ClientProxiedBy: SG2PR04CA0165.apcprd04.prod.outlook.com (2603:1096:4::27)
 To DM4PR11MB5423.namprd11.prod.outlook.com (2603:10b6:5:39b::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB5423:EE_|DM6PR11MB4625:EE_
X-MS-Office365-Filtering-Correlation-Id: d529451e-818b-486e-cd7e-08dd61c7bccc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aGhlNVlZRC9IY1ZMR01iTE8rMlFPcEV0YURoQUpZS1daQVRRVi9ERGY0NENZ?=
 =?utf-8?B?bXRERFJGVTFvb1BVOWJWV25ia3RwU2g2eSsvRVF0REluNURTUWtzeUdhSCs4?=
 =?utf-8?B?MVZxQWE0bFY1NW5JR3paVm5aSWhyZzhoYlNPNEVUK2gycytJZzhVZUJmcEJm?=
 =?utf-8?B?OUNKdVQ2dEhXanNqamI4eXlmb3ZOc3JlWWhRNkpGODNhZWVnd3dsSGFKVURN?=
 =?utf-8?B?ZFh6QlBrRzRBYVJHV2dmS1lIT3p4ZCtWTnhiczZvK3o2VVFpSEtaZlpMTmVj?=
 =?utf-8?B?Z2UxSGJZWTdxN0czVGY0WllROEd1Wjd6SUkzMnptMTNFQ2dUY3o2RUZ3WXVV?=
 =?utf-8?B?a0lGUjZ4SitCMVU4c3BreHpQcUcvUTVmYVByQWk0eVF6YngydEN5TkRjUm0z?=
 =?utf-8?B?Ri9NdmtaS1JEVGh1MGFuUWdCRHhRUkJqWUpEUENrRU1ubUZDUWhiNEJRb3FM?=
 =?utf-8?B?Umd0MFU1WUdvemU1UHN2by9USlV4ZUZrMU9ZU2R4ZU9VTDhCYjFXU2hMK0ov?=
 =?utf-8?B?MThDK2RPeG1ON3hrbm8xNGIvcjd0NDd1ZFJJYTE5UG5uWEJaQkRiUitRbTFG?=
 =?utf-8?B?QzBnWUFWcEx2Q3VSNEpNUTlyVEcwYWxZY2Zlc3JFOUhHcjloSVB4NmI3b0lx?=
 =?utf-8?B?TUpmU0JrUUc1dWhRWnVyYzVXZEpWQmpDM0hLNS9ZQURZNkZIem8xMFRybWRa?=
 =?utf-8?B?UWgxTzhXRzJmcmxCSithdEl4VWZsaGRETzNib3gwODV4OEk0WlRuMTk5YlVl?=
 =?utf-8?B?L0lBNGVLZmRrU1VadGhyOFpQM2ZBUFVRRVg2dnlFZTZ2L1VRb2l2L3l3UVEx?=
 =?utf-8?B?bDBZT0t1QnkvS1FHcEUxSEJ6b0J1bmRXMHZacWo0OTZxZFAxdTdwL3lWR3ZV?=
 =?utf-8?B?Tm5OMWVGQnpDN3hJY21KT25pbXQvMVpSdzA5eXAwN2l0aEpXT1drQWlNOGtv?=
 =?utf-8?B?dzNWQm45ZDhWSVlKOWJLa3prK20yR0VVd3AzMndUMEJmS1duVzBQN2VsVUdF?=
 =?utf-8?B?MDA5ZTBJQ2tXVEFKUEpKRkQyY3dOd0lkV1E1OXJwMVE2UVFYTlJsMTJxelR5?=
 =?utf-8?B?QkJmbWZtZnJZS2NkbS81K3dZWnVOazRMTmtVK3luR0NsRDh2SC9kdlQvQzlC?=
 =?utf-8?B?YkFFblc3azRnQTQ3UEY5YUdYckFLR0hYQ1FPaDFJVjRFUGhpOERCbW1sblUy?=
 =?utf-8?B?NUlzMkpuVjErTGpoTHFYODdDcllzSVlyN0thSHpqVzdnc2gxZ3JTeU1yYW4z?=
 =?utf-8?B?MEhOY2xPRTdrODlSS1JFcFVNTlEwOEVmOWlCWXFmdDUvZHRUVk9jcUxsamtL?=
 =?utf-8?B?S0FSNGRrN1UwZEsyMzR1UytOYUo5N3pnODJpQ3djU0l2OExLcFV5aFhLbDJr?=
 =?utf-8?B?R05OVG03TFhhVWVqMElidHZrZ2M5K0VSUThlZ0hKYzcwbjAyNVRxWHpXSHhv?=
 =?utf-8?B?T2FnUkxiUDNDcVFFOEUxLzJaZHNLaFpzVFBLVFkxdERMZldiVUEwOHhDUzlV?=
 =?utf-8?B?NmZYRTIzbHJ3MUFySitPT0lEOSswQStLNFovOWV0U2loOUtTV3ViMmo0aSsw?=
 =?utf-8?B?QlhjSFNWMVZYbXdrcG5ZcGdHZ2lBcGpYUE4xTzhiaTlIN2NxSkpBcC9lTC9Y?=
 =?utf-8?B?dGYxTW81K05DbzVudzlUTnM0TjdmS3NtNXBLMlVVOEI2TlZzTHNmSlVlbFA3?=
 =?utf-8?B?bFR3TjF2UG41cDJ6eUFWd1hLWHV5bG0rY0htU1JXekF3YklIZWxvYi9DbG02?=
 =?utf-8?B?MUY2Nm5MMTIyZFNQdFh5ZURNcXdvOTlUNzhlMG45MlhNZXp1UnJWbjVlazlP?=
 =?utf-8?B?dXNKeFBMQS8xUjVOeUZpUlIvU2lVUXE4TkdxSW9QN2ZydTRJSWJlWjF5SC93?=
 =?utf-8?Q?IBxNWhVamSIv3?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5423.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UU92Z1d3NFNGWkNlTjlNaXl4ZHBOZmplaXZMOXRHMiszdHM4ck5EMThFSGlC?=
 =?utf-8?B?WkVBY04yZnBJYlpuUXdSSk5UMDE3OHZBeEhqeWo4TlB6aEp5NmdWL2hJNHNj?=
 =?utf-8?B?d1ZGZGRsTzJLNkVGdk11VFdxSFovK3ZheXhpalRvYVh0eVQwNmt5SHBrUW5T?=
 =?utf-8?B?Sythbk12RjlKNkh3WDVBOTNHbDhYVUNIUEJrZXc1VEhOY0lnWkxIRDNoTytP?=
 =?utf-8?B?cjlXaVBQNk9WS3M4c0JPb3FvR3YxNENORSt5UGRTYVNHZjNqNkVKTHYzSnBU?=
 =?utf-8?B?R1crclo0TGdIWERyc0FUU041bU5lZTYxNm0wWWJJSHpIVW5HVm5nZTFiVXlp?=
 =?utf-8?B?T01rdXZUU1hucWxveE9CK2ZDaXMxL2J6K2NUcm00aWtwTmwzWUZLanFVbXk4?=
 =?utf-8?B?bEJGTXdjL1BIY2QxeHljUUdSZW9sOUl3Tms1anRCSk1sZWxNUXFEM1pnb3R5?=
 =?utf-8?B?Q3NuZFd4cDVuVEhLTzBwMDNEVERnY01LY2ZKZjdSUVUvM3lhdURRQTNtWmdi?=
 =?utf-8?B?L29YQzd2MTBScHdMUUFocmNGOFZBYTNBYmM3c1lveXQvS2U4QzhHUHRVWE9E?=
 =?utf-8?B?Mk4rMmwyUkN1bHlqaEgweHdhWFE5NExKQ3dyOHdleVlpZHNzQTRqcnNIVCth?=
 =?utf-8?B?aE4rL2M4MFphMENEMFFUdlhaZ2J5eWRLZzV6dzZ1QVZGK2dnU20yMmVLMCtm?=
 =?utf-8?B?VlFMZTAyVXVsVzV3TUhBaFJhVkd6R1o0N3BRVFlXZ2p2aVQvQW5icDllMkxG?=
 =?utf-8?B?dTdFSzVmR0syckp1RWdIZENPOFBCeTFDd3Q1L1NyS0o5UGNJcGNraFo4aVZo?=
 =?utf-8?B?azUwcWNPd0ViUnB1RHR1VlBoZEZnNnhNQU05WFI0OE1FOU15R2Y1RGI0ekJJ?=
 =?utf-8?B?RVJmamdZbk96cGFWaUFwZ2ZQRVVzc2pkdWNXQ3dQdHBmR3Z4ZTArV1Q5T29s?=
 =?utf-8?B?Wi9PQ0tNUUVIRmNJY0pRdVFEbzBkWHE5N21EdzBLSDVjZzZobWtvQ3M0MGNY?=
 =?utf-8?B?QjltQkJOQ0FwUkJzbHBtSzk0RG84NS92SHFxdlRteWdhQXJjUVorRytkMEo0?=
 =?utf-8?B?cFJIV2JQNWJHcDlLemtsWDFjSC8ydVRQYUREYldZQjNzdzA3MjNlYVZaNWlK?=
 =?utf-8?B?T21TVi9PbVEzcFZYRkpXT2ZPZlBnUXpLVXVjYzJRZ3I3bUE3c1JVMVBTUmJa?=
 =?utf-8?B?bi9SS2FlTGRFRTBsQ1Q5YlBpWlprWThwdVpmZ3Y4aVFFSXB2ZkNKRHdxbUZ1?=
 =?utf-8?B?SkZwUUtaU1gwZ0NocFNtVStXWGpielY2M0lrbzJaRzFnblBnd3FzN2grRTB1?=
 =?utf-8?B?UGNrcjE0eGYzSUhIb1VHTVYyZURnMFU0THNWaGhwaHdITGdhQWgwaXBpbXM5?=
 =?utf-8?B?TFFWUzErRFQ3RWdiN2RMN0w1UTJhMkUvd1JmWmR4S1FicnhaVU0reU9nSFA5?=
 =?utf-8?B?ZFpjbk1RTFJDay9LeXBxUm1kaTVzZG9kSHp2aVdSTlptRGh1RlgvRlF2UjN5?=
 =?utf-8?B?amViM0VlNTlFWFhOcnlhbjgvL3VwM2M0K29LQ2sweCsxYzNkUzJsQng3U3FV?=
 =?utf-8?B?S2RoTE91YU9YYWpLakUxck1kT3k1bUtTNzEzQlpMYXJqdUJuYWl6MGZzaTQv?=
 =?utf-8?B?L0FyRS9Vbzk2ZEJpc1BwNWhCSWVwbEFyNEZkUDBNd0FoNjJieDZLd3ZEQmtB?=
 =?utf-8?B?SWJsZ1hkTUVRSngydDdNcGdqZkJhUlZGYnZWZzB4aFlIRVM2dlEvb204UHIv?=
 =?utf-8?B?RTJQNTk1TkNSTS9FZTFKZUFtZGx6c1RMTklHQUlMbHNKSElMOWFNZW5naTB5?=
 =?utf-8?B?QnRVRW5yWTNwM09JM0dPSkJsSHppdTcxeElDc2VPbHQ0c0NiclhVZVZveVZM?=
 =?utf-8?B?VmxoM3FiRlV2SUpRY2xqbUljVmZ3WG1WS0FBVWxnS1pGcm5VSk5FdVRKRVNU?=
 =?utf-8?B?bnhyWXBRR21kOXBCbVlTcTFSMlNkZ3VrTXFMQ2FvVXJ1NFBTUjgyYXZPYklk?=
 =?utf-8?B?UTlzNi9vdDZ0QkNURHVKOG1qT0RLZ1pNUjVTNXpmbGptN2M3cHpXdk9IbDNt?=
 =?utf-8?B?NmcxRWVVYnNLYTlaVWtsUkJ2WUlFaVFESmZvR2F2d2ZXQ05MSjhFdks0WG03?=
 =?utf-8?Q?oxWqV/UazH36kOq7MFi4LtNsM?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d529451e-818b-486e-cd7e-08dd61c7bccc
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5423.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 00:41:05.3457
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aNXRWf7PKQZIPVrsC354c32MBYnhmVt8W4qkZQdIFlV2FUn5Jui67xr+Y9mxpcErZqK+fc05MBVLBYkDjT9X5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4625
X-OriginatorOrg: intel.com

On Tue, Mar 11, 2025 at 09:49:56PM +0100, Miguel Ojeda wrote:
> On Tue, Mar 11, 2025 at 9:44 PM Tamir Duberstein <tamird@gmail.com> wrote:
> >
> > By the way, it would be great if the email also included the rustc version used.
> 
> Yeah, I think I may have mentioned it at some point... For the moment,

Sorry about this, I will implement this to make it clear asap.

> one can look for it manually in the linked config (i.e.
> `CONFIG_RUSTC_VERSION_TEXT`).
> 
> Cheers,
> Miguel
> 

