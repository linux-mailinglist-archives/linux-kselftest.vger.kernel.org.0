Return-Path: <linux-kselftest+bounces-46845-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B4160C9903F
	for <lists+linux-kselftest@lfdr.de>; Mon, 01 Dec 2025 21:26:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 79CDB4E1BC1
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Dec 2025 20:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C149248F57;
	Mon,  1 Dec 2025 20:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LfXRzX8V"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08FF136D50A;
	Mon,  1 Dec 2025 20:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764620779; cv=fail; b=cRGnYWjstvedrVAlrGV8vrl2WWQgy2pZNAxMDZJoPEM4cmoQiDOdaAO2mxWIllBhSZz4S9P/y8B3SrqIgongC22u9fMtA6h/edqrzuZ3jQlOCBH29ynCyz4tWe5cEsfH4dUPZgFzHuQHvgTy9xlTx8YFRZu0uUL7X7zMbUaT3VA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764620779; c=relaxed/simple;
	bh=4S3VR/OwjU3yeOjtoN6Wtql45IDGcUptYcROM/EcYOM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cdf+//twNjmo6eEXeNJUk7f+96rkTtiaAFp/DNgCzTWf4Il5L0zowbN5HKdeQhUFDvwGkIRnP6oz+VUIJYEtuD4RND3oElfDfOTuPzyzPuABgKaB/+NrPMI+Q3MTNw9yi5fZVJm77lREASD2+0GpjZhttX01vPllZhDtjNSPdSM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LfXRzX8V; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764620778; x=1796156778;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=4S3VR/OwjU3yeOjtoN6Wtql45IDGcUptYcROM/EcYOM=;
  b=LfXRzX8V42JLgvrSaJYiJmaCIcMsvbZuyNuu+/IhLQF2ivI7Qpnuazk9
   jn6h3ZSlmU2LNJcqNif7oa/9KmXYX3Df84e/4DxdR6TFl6vOZGInMyMxl
   aaZaUAPWcxkukO2TOShnd3M1Ov6OngGEweOqp4nCHKNRvMsRjgLM09yO3
   Gt+vfJBg3/U38yMDYBF0aKxqJueDbD7PNPXmW3NkvFcIkr8HPFdbyL+68
   R96sOxMiuDP7KLQYbznUIiA/DnnokGqtXMPRK0IcvdXZnEjePgq9KXdL/
   SzV5qpqmatiz+jlDlwIWkQttAGUUfH4ydhIhGfOndlq18gagi5n7LdZBz
   w==;
X-CSE-ConnectionGUID: H53e3U6MSLmMrb0l0kmjSg==
X-CSE-MsgGUID: I7XRL4ZYR6+nujSnMVrDhg==
X-IronPort-AV: E=McAfee;i="6800,10657,11630"; a="92050670"
X-IronPort-AV: E=Sophos;i="6.20,241,1758610800"; 
   d="scan'208";a="92050670"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2025 12:26:17 -0800
X-CSE-ConnectionGUID: M08tHa+pRqeUpN4E8D3+cA==
X-CSE-MsgGUID: MLkbE8PPTiCGZdzhzjKRKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,241,1758610800"; 
   d="scan'208";a="198540938"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2025 12:26:17 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 1 Dec 2025 12:26:16 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Mon, 1 Dec 2025 12:26:16 -0800
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.60) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 1 Dec 2025 12:26:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o0F1vBFDTEfRmEV67FuWWu3coT7F86XPywwMClsOQoFv0slYUy4bX9X16G2bEo3+gAd0a/DskZ4eYuCx6wjflHDBgEg+2+H66hWYgHYAm2xbuO28BkkL5dRo4wanUg4l6p6Uq6gOAowoHVEJr6N2IE8cTnovQvRtTw6yRuEfFtBv2yHVAW6OT9GYyjpRYeUg5r0u5TMlLj/aFV+EIlYg1lRI2mHUTGkroSjupX/OddSVcFrlzv3MNFVVPscbVfZ4gYxHZhAcZtz/6eKMjehVy6haoaw8fdKDxyg/DG07zTmcsB1AyGMUDrcDFSjUEumjiXb3nRS1zGK3njNc0FBqjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PPdoizoU6uvqD8GOq7aqipjlcQjkFPFHgBSYCiHX9IA=;
 b=PSO0K8y0tVgQlae6X4eq0J4+DO5vNwgob5rvjFIZBPutf3PnOjPMOYr7dQTNS8GNSCeYhs8IWN3JJ1GxtARbrIvwy9NYGSowF4PcJ8GjM4dtGES5WgJyz/kpNayFQiIgL/RzVBHLtsqfWdtDudTwyJ7jLKn+t+5II29isBsAnc92L8mF6i2ctzMdIMiXuRJqPxqNCnGq1Wseb89xekN6pA0A5mQstQXNBFBQgPfQf40kLyXeGCn4Yz5AY9MLR3cW1TkW1RbT6f5yy/OHNNSXJyt8umufA/SbZqPlEDBGfvhs6bStR1ZgRbcvggmtvUKgXthRq4FC0gyAI02BzAh8Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c) by SA2PR11MB5019.namprd11.prod.outlook.com
 (2603:10b6:806:f8::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 20:26:12 +0000
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::8289:cecc:ea5b:f0c]) by PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::8289:cecc:ea5b:f0c%8]) with mapi id 15.20.9366.012; Mon, 1 Dec 2025
 20:26:12 +0000
Date: Mon, 1 Dec 2025 14:28:45 -0600
From: Ira Weiny <ira.weiny@intel.com>
To: Ira Weiny <ira.weiny@intel.com>, Sagi Shahar <sagis@google.com>,
	<linux-kselftest@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
	"Shuah Khan" <shuah@kernel.org>, Sean Christopherson <seanjc@google.com>,
	"Ackerley Tng" <ackerleytng@google.com>, Ryan Afranji <afranji@google.com>,
	Andrew Jones <ajones@ventanamicro.com>, Isaku Yamahata
	<isaku.yamahata@intel.com>, "Erdem Aktas" <erdemaktas@google.com>, Rick
 Edgecombe <rick.p.edgecombe@intel.com>, Roger Wang <runanwang@google.com>,
	Binbin Wu <binbin.wu@linux.intel.com>, Oliver Upton <oliver.upton@linux.dev>,
	"Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, Reinette Chatre
	<reinette.chatre@intel.com>, Chao Gao <chao.gao@intel.com>, Chenyi Qiang
	<chenyi.qiang@intel.com>
CC: <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>
Subject: Re: [PATCH v12 08/23] KVM: selftests: Define structs to pass
 parameters to TDX boot code
Message-ID: <692dfa7d2bc37_b5bb100be@iweiny-mobl.notmuch>
References: <20251028212052.200523-1-sagis@google.com>
 <20251028212052.200523-9-sagis@google.com>
 <69277ffdd6058_9480d10071@iweiny-mobl.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <69277ffdd6058_9480d10071@iweiny-mobl.notmuch>
X-ClientProxiedBy: SJ0PR03CA0033.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::8) To PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PPF9E162731D:EE_|SA2PR11MB5019:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ac22d06-3779-4871-023d-08de3117de9c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FKvugecndma+czj+fbUcJB7O9+hZIMf6JTnkCh/qBBKKsE9PcKScoUsFV35E?=
 =?us-ascii?Q?wHv8+dJ4qfKdb1+SWQCKnoJFpuDvjRV4NYU9OBjqJ8/kITcU4kErCjG//8pG?=
 =?us-ascii?Q?wSYZunpaGWd7j3cU0KWABr2920tY92/t2n/5DKyF2JcccGEFRVIVO2AgNzvc?=
 =?us-ascii?Q?fyRB5znYde6aptOT+B5/ZweuBW4xWSpaQuKxsHxO3ZyAEWvKdSWmkgdqf6je?=
 =?us-ascii?Q?+xM3C1AECAz/mbsVrAKTnpUL17UomYcxEG48ckSQYAO62bt80hCduz55Q7v/?=
 =?us-ascii?Q?JJRkvB4eFHnH4T9/oBqzEsirVQCAFgb8FHqC0tbI55zm/MS7y2ggXYXavo34?=
 =?us-ascii?Q?QZBRVFhCOVxoqYk3wtVbr221EWqlSSbamSKlgOB2Vigr9ezb3eWUeVPMEpns?=
 =?us-ascii?Q?AM/MUi/iH0od2E/7RyfKc31/9ZVaw5/FriAUnqEkwP+jLOFGcdZUqFK2nO11?=
 =?us-ascii?Q?lICnZlixf7XOWqRPE0NgvWyeS9lH8Gk4G5d4SkwNPsYSgdtXrcO/XIYdl6Y7?=
 =?us-ascii?Q?hLPuvw+0rhyr2HwyHbVY0AJnMVWsXOuYg3Cp9/gSmjvE5O9kTJUYlmv732Rb?=
 =?us-ascii?Q?bh0CqR0sU61cwqb0m/5XhMOwGRLIXDRYSSsyxJxNUpsYs7hR95IwE/7YB9qz?=
 =?us-ascii?Q?eeHSESBBjr38vYp4ydPETM0o64bNAKI2EGyEViH7SAkg2Uv1mJajrdUAgMgf?=
 =?us-ascii?Q?sMx8n0Sr1dhlP2wTktOl5oYaKggBliA5QNqIhkPLdMZKur1w8RlZ2cw9QjRD?=
 =?us-ascii?Q?K/K1IsILbLJMAOKJjo6Ac1/sVa37UjpPBm01xztZwaZY5W8BFTo/lxQFNWrC?=
 =?us-ascii?Q?p6Sht2Wcn1rbZDT4BBKdvgsaxD6pjL7QZwaq0lUktgUkUe9pM/154ekgCN/D?=
 =?us-ascii?Q?tC/FuBEXrCuQWZxos0Tz37klxvBF7xwr8pGZ8zOxbl4gh3LFUobY/EAnT4MX?=
 =?us-ascii?Q?A/zaHe/MyJaQY+WG5Z2obtILRYy4uso4zoSplaeMXQYMhR1fbFbF669xs/3W?=
 =?us-ascii?Q?MQL2NmX56KAt3eRgmjL9pvODjViKKoktCbGZFUgkKARkOyZ3qWT/8ayXPL2F?=
 =?us-ascii?Q?YHwQ6PjH3LOjEKlIcr21D6y+vbsE5Pt1+I2Ii49f5mjj1oCUu2VYr/HIV9kV?=
 =?us-ascii?Q?FUkBKgW35xoPGEC2QvkRshUfINzh9vBalQOQ4QCzTeUXl7zKA9Nq53ctC6rW?=
 =?us-ascii?Q?5Qc8y8VoMDEZhJoAxhTkWwZre0RMc8NLOahoqrGABbKUgbX7TcJ1+89RqOTM?=
 =?us-ascii?Q?WgKI9sWPB9nlPjqOB2PmGKWGcwRX0pusfdyvcmDAzdTeWhJ9ErQc/wgZrEZ8?=
 =?us-ascii?Q?XxC0vyo3DLfXDw4z8UF56zNVQ0vCyiSYOSSqBgZaxvzfyL0Ohskn80fCeYAp?=
 =?us-ascii?Q?JcOF93IKAnF9dyVR/9kwTOGrcv1aOioIjtLlt7ON7HF6PuTRpDxOu7rDJVLP?=
 =?us-ascii?Q?Z2ELrvzzt7lnMA8DpeBzj6GJZsG6gmQHghj99QGoWfBLcZ/3lJNS848xv2Np?=
 =?us-ascii?Q?dlLa354IseYL/cU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH3PPF9E162731D.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jtSVhGf6RYcH/3oZx+dIRiLylIqKH0LSnOvQJLTKiESpRpCXmJScK7s0KuIh?=
 =?us-ascii?Q?VqPR6Vazc5+jJ2a3oIgXVlpSsh/5nS0petR3ogNz2kZyMj9y5ZszKqf7Ms7m?=
 =?us-ascii?Q?KVIvGD4n36a5RrOYZjrSJW8F+f7nKz/FVPDtuz0wp+Yv8XXv4FxYMYVfVxNs?=
 =?us-ascii?Q?0q8DlweZY3V40LcFPBFD5JWJ1lgO+fHCDT8gB6n1yhKbE5l7l0I6E7bUzufp?=
 =?us-ascii?Q?Md9GBv6J45TKSj5EB3bwVinr4snA2zuEr6BCCLeBaewFnQ0DoV3rTCvlOBnb?=
 =?us-ascii?Q?rZ4wnKadQtje+LHJK0zh3R8J2t65g5+TvB3PgG+XDTesAWYms1uO/XFuY9kd?=
 =?us-ascii?Q?5SvYA9bkfKKgHgNkwr/P8jwYFyVyUhWFJM5In58WUBJysGVjgqwMsO50ZliK?=
 =?us-ascii?Q?U0rwSTX/L2XbUK9nY1YcNQ0eVAgFvOeVvsWqfKmrAk4rmDzT79HeVLRM5nsN?=
 =?us-ascii?Q?SaEKGETU4czoCiBdvbTp0BtJs4N7fdbmpJggi3TWRok+r17OH/OCh3rQHeYi?=
 =?us-ascii?Q?3B0HNfYV3r05ExDicE59QIeUBBwuLZrkxErElnCiXseIqInCOfW5wBrk0nzR?=
 =?us-ascii?Q?pKsTigBBNtyAmTFJpZvk/dQMOait+8gvRz1owtw2XLvUhnk8U4esSRuAO/JP?=
 =?us-ascii?Q?2+oR1XhJ3Hl7MRI36Abjw6tclImymny2Pfn/Y2hiB3dTyaaUFS6pe+BMswAY?=
 =?us-ascii?Q?86yIBzwff2Rq+oaxNHzNeTUL93UkJb3qtcxY5CeDGhwmVHuREoVNCA92qKp8?=
 =?us-ascii?Q?LjnGBqoEIHoWHof9psbYhPk3zebtplXePYBGOpsUVuMi6hbSl1U3QTHxgMah?=
 =?us-ascii?Q?4FPTilxl+S6qEUjZ31EgkeyqsieCtJyxoo0SOvdi00XBrydbrkCXsTU5QsKr?=
 =?us-ascii?Q?5/nqnz6Jh50i7gCELNyYr5P5nX5xBaYTwETLlk6mHXMYZDu+5MJOfTmEh0sL?=
 =?us-ascii?Q?4s4nIo8NW41dZfaC7febKXHTYztsQyTaAuaWVVZcuQATJs1gYCULlThP7pz4?=
 =?us-ascii?Q?P9SwYtWdrH2upBZhLEl4qd4In4Bf9wBKAECBDdpccadLyXbK3uEqR8jPFJxi?=
 =?us-ascii?Q?0OmXrqioSgTM7h4A5F10Gjw7vtOm79mUguicZqsNdTp+DTBDA841MN/sFxnF?=
 =?us-ascii?Q?7yvD12Rt3HpJwHHsRqthefoMq/3C8tWX72I0SlUqt76GR42WhfbnW4shpD05?=
 =?us-ascii?Q?ZPZUEvJXhGpXyAJbjsqPg9LIYLD9Jusa3HwFfzzWpPI7Uu8ZoQCNyJVYVz6Q?=
 =?us-ascii?Q?JQuUdwFOdF/yt7YEDQUSqAjuQJ7s5L5MbDtm1B0SmeevsNqYHy1sUoeUv127?=
 =?us-ascii?Q?QXMgdsBiqymDCZU2TIj6CxXNX69cZW1iC+Ak++Gkug6zmVeQ1f1RYHfkMWUx?=
 =?us-ascii?Q?SmmENDqXTXK+4t9UJdiD8qx11UY1Si6Ug9w4+Ryz90Wh3bwlAjIVplfrx8K6?=
 =?us-ascii?Q?fKUyi6wRjG6yfOuO24+BWodMBa5vlc3WCpm7R6CaBfRXLY658bNMJ0bI297P?=
 =?us-ascii?Q?9k+1ygpBs0Bp0IHpcWJIf1LOAtcyGT/ZmjJtHYXCL9ibaYBsd13+0XgKTH90?=
 =?us-ascii?Q?JcxIn9wJVBCruaM0H0hR8R3qaMmOeWc2v0zfBwFV?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ac22d06-3779-4871-023d-08de3117de9c
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF9E162731D.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 20:26:12.3804
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E0egHMp4uCqwRjplXR99L3nNkQB6nrAka8+gpu8J6LpfIHMfbkYEL63Xsuqu+NHvPSvJvDA0wGq9viFItkQyuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5019
X-OriginatorOrg: intel.com

Ira Weiny wrote:
> Sagi Shahar wrote:

[snip]

> >  
> > +$(OUTPUT)/include/x86/tdx/td_boot_offsets.h: $(OUTPUT)/lib/x86/tdx/td_boot_offsets.s FORCE
> > +	$(call filechk,offsets,__TDX_BOOT_OFFSETS_H__)
> > +
> > +EXTRA_CLEAN += $(OUTPUT)/include/x86/tdx/td_boot_offsets.h
> > +
> 
> I just noticed we should add this and tdcall_offsets.h to .gitignore since
> they are not auto generated.
           ^^^
	   now

Just to be clear.
Ira

[snip]

