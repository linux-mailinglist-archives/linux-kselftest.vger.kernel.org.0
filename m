Return-Path: <linux-kselftest+bounces-39608-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16151B308C2
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 23:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9327CA28563
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 21:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B0712EBB88;
	Thu, 21 Aug 2025 21:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BeJEd47o"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72EB32EB849;
	Thu, 21 Aug 2025 21:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755813539; cv=fail; b=CjVXe71aq7WF2NN1cQzYPzUl5sUA0gQ6aSHvEcOo031SbNGv/ntk4kN/7ZiDCQsoGNzkr6brDN248TYAIYQE3GwsBO0hj0BwReE8ZMdivtq2L4Losaml+MyD+rabW1mvTyRj/8XfIWVLmGDEasHugt272b89qhX5dDt0bc1akas=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755813539; c=relaxed/simple;
	bh=d9UXlfTUjmdR0HzUnqd6gdycQMN7NYDG12ipAPsnQi0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RyMtxZuV8kYP5G65HH76qwgN93+fU2vA/H747M6fj1KBf8ufkXzz8peAQ+/kXNuI+iph+EUP//RbkUr0X7CVDTSwzLAtTCogl0I9JllPCK1ClPtcR6hOTZtrvgDkixXU8D+avOlSdoN3ZgUXK/odUZxB6Uk5T6uEhA2F3P0/cc0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BeJEd47o; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755813538; x=1787349538;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=d9UXlfTUjmdR0HzUnqd6gdycQMN7NYDG12ipAPsnQi0=;
  b=BeJEd47oxmYcs6InX5kWV7haW9n3nhe1oyPkUR+6JzgH+NlmgJt2WbDF
   bKaKSLxTNDRD+yJJetFmg1R00TZ0PC7QHQIGvfPJldcOz0awYnS+Xvg2z
   qwaUxoM/dQsOyVQsSAloTx/GQJkxEdok4ZmFP1h8xdqFYwL8YOtZ9lPPi
   nGF+iB/lL5BAPQ4Z+PqykZ97IPcv5YOo+0BEdUCT3ak3/OVSzoHoU/NQM
   zg04VgDRSoM1QXliRC1AlEaB2zNtAZiLqZbMVqk7yNQeCnLjT+SXZX8+G
   JQ26YvLmGdv4sEWA/es1MJH2ePTFfNg66ih+zYA0rpMb1teO1/0hb9lSF
   w==;
X-CSE-ConnectionGUID: mf37pp9RQvSNibWzzhZlsg==
X-CSE-MsgGUID: TLz6dY3kRBad7rbLKgXO1A==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="57320271"
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="57320271"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 14:58:57 -0700
X-CSE-ConnectionGUID: bfLVjeKxS2masqWpihdiLw==
X-CSE-MsgGUID: LdmGmgE6TtqMsEQ5rjYxog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="169343442"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 14:58:56 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 21 Aug 2025 14:58:56 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 21 Aug 2025 14:58:56 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.68)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 21 Aug 2025 14:58:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ty+5zhJ7d1Bd2vOIM93gtHl975duXK9DCCcNUopZWyPxkeNQrAT99MczYjL8oueSblt3dbG8rJZbn78HCSE6fMdnIwgd72vTTu5MicQznUJUIuxnVP8K+TdYeOZ91Cx5b05Z1raYHm+AVMPwiyglpXJ78zRpREcrXGf/GZ+sTNG5LDilD21GS2vWQOlQTjLTAX47GwgAfD0TM/xB5G2qO/BuoLd7KJAdXRUQWcmTgPd4kjEQQvqG/F74D9PrFvLp6vE6E489uePLlDsP6VRIJEJZa/9FhGaYpcZsTm/X2I7l4JNXai2Q14zs6epgidE5lnEnWWeWla822TkcTAvvaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=paLyE+I4c8qvx3b0jp72pqufcxBmd0I+5Xw681tMY3I=;
 b=ADbNrb0ZrVQLmb4zVao2hOHlFfADp2DSsm7jst3W4V18/UyDRMYS1u99yDXwqPYSL4Nx4mp092Zgn2WTSCM6lAQRRQeEtpG3OpDBjIiIwNOxK/tYp05kcOAlS4ovUrf8nLeyj7phZ9QRExPWuPFEG+2HO+F/UjYU0QmMgH8K7kieCcOKb3CFQD3Yj6w9w/Z9XfqGGeuX7QHUSRAlRFRLvPWMYJz/T9oI7oasZGUuosB4h4sKyoy2N6XliJka/rNs3AtMnxX3mhXX/kZ8nxDUSjOvj2UcIawIpT+SEsnwtBninh8aEOBCseRJc1+Imo6F7vIlIGbtPl5FZ3Ekx82pmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c) by IA0PR11MB7695.namprd11.prod.outlook.com
 (2603:10b6:208:400::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Thu, 21 Aug
 2025 21:58:52 +0000
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::bbd5:541c:86ba:3efa]) by PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::bbd5:541c:86ba:3efa%7]) with mapi id 15.20.9052.013; Thu, 21 Aug 2025
 21:58:51 +0000
Date: Thu, 21 Aug 2025 17:00:35 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Sagi Shahar <sagis@google.com>, <linux-kselftest@vger.kernel.org>, "Paolo
 Bonzini" <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, "Sean
 Christopherson" <seanjc@google.com>, Ackerley Tng <ackerleytng@google.com>,
	Ryan Afranji <afranji@google.com>, Andrew Jones <ajones@ventanamicro.com>,
	Isaku Yamahata <isaku.yamahata@intel.com>, Erdem Aktas
	<erdemaktas@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, "Roger
 Wang" <runanwang@google.com>, Binbin Wu <binbin.wu@linux.intel.com>, "Oliver
 Upton" <oliver.upton@linux.dev>, "Pratik R. Sampat"
	<pratikrajesh.sampat@amd.com>, Reinette Chatre <reinette.chatre@intel.com>,
	Ira Weiny <ira.weiny@intel.com>, Chao Gao <chao.gao@intel.com>, Chenyi Qiang
	<chenyi.qiang@intel.com>
CC: <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>
Subject: Re: [PATCH v9 04/19] KVM: selftests: Expose function to allocate
 guest vCPU stack
Message-ID: <68a797031c5a6_2be23a29461@iweiny-mobl.notmuch>
References: <20250821042915.3712925-1-sagis@google.com>
 <20250821042915.3712925-5-sagis@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250821042915.3712925-5-sagis@google.com>
X-ClientProxiedBy: MW4PR03CA0292.namprd03.prod.outlook.com
 (2603:10b6:303:b5::27) To PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PPF9E162731D:EE_|IA0PR11MB7695:EE_
X-MS-Office365-Filtering-Correlation-Id: 590e1994-1d5e-40e1-74f2-08dde0fdea23
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ya4N645V8oYHn9v2yfcysjNmFwKpEMBgfP8VDv3obrdUSwrVPRr0EVd02qsD?=
 =?us-ascii?Q?hejB5XJ1nvsOO/6/af2lT4XSnhn9mxF9VuKUgqVYpuFqu1Hmu1c1rQ/CtAq1?=
 =?us-ascii?Q?d1K2FYljEycuYKNQdJm8Z6N+4CMPZHsZJ1/f/6YLiBpvyMFfUaMCFIicCvI7?=
 =?us-ascii?Q?lcInPHwMN0JmknNcNZFaKlb1JLoXL02F5y/Yg4C/oSG4BQKRKBtTXf8w4JtF?=
 =?us-ascii?Q?4j0Efa7grnXJNGQR37aaARqFgrDXkJaCoFFHW/ev+zObNFZZjlnbzHkAKHlA?=
 =?us-ascii?Q?u+1It7WAlhjpUmVN91xxU4w7LAp3X343jTJc9pZU7Xxc4zd1i0z+/ipvg/4C?=
 =?us-ascii?Q?mR8yScD1QLdZOBKSPW8tzQ72SNNlZYuSm3LXxKwbXp+p1DLJb0CWg0ZWLWws?=
 =?us-ascii?Q?vk0SaiIbqPW3lNhI3WnNBvp5s1OVQodxaAYqVAuxWRyiTd/fO27cxCfl5xww?=
 =?us-ascii?Q?eGsgh+KIZwdOuX0Q9o0IcZ6N3gMIJTb9wUqUHPnKz2wbqbSHESXeN6gj/tTK?=
 =?us-ascii?Q?rh7znDPFafnMlns8xOYPdxKl6NgPUVIT2J/zBy4KotI0AOkqyTCGWekNgYU/?=
 =?us-ascii?Q?OC+mNH+dDlBQGQeCC1Xq4r9hfcR6qxZNNWMSEQk199KLOuvGbr0Ve8XoYouc?=
 =?us-ascii?Q?IEnElz5dlEb7vv94yUypI6m+BsYx8Q3sD6hNUlfGv6HSesXdjdBEiYRa8dNp?=
 =?us-ascii?Q?ojRMd9PFrc09Mx7mv4PeHUPW2KATX/JL7mH/6TWuoPNNJzOSBDHPJeBcfytX?=
 =?us-ascii?Q?TZFc9opk5hwX6SjMmvyU8QUU+msj1yc4nT02reDHWfOBChxmv6cAezEitlwO?=
 =?us-ascii?Q?1VCpGPAbCTpDW0nYEH+iaWNtSFavKdV+MQAKZwsGc1q0Ay+dQDRPRbFKOegF?=
 =?us-ascii?Q?E28H4at/Y+692k8B1CmgRJp6RmYIvNdo/+Y8p/FpDfDut2wRbfHnds2EQJg7?=
 =?us-ascii?Q?DvANOLvPZZ/BKqfJ8VIo1r2QfyYBNJesjyv3OaXW3rHpuB/3R7Rk0kYDbLKt?=
 =?us-ascii?Q?M3LEh8qnt4E7MlQPcD+awRyrQEgR9WlgCb0bYzV436fkQr4T5qWUb70T84SZ?=
 =?us-ascii?Q?mXL/uvltF8+8G5toUfNDqOrM7LvQGoMYQ1AKxwG2VY8pdX4l9K0sS5Nns9NE?=
 =?us-ascii?Q?LkTN1xbd+PC+ekrSC7CBl+1b+wM6WHAx76+1eem0D61masSMIyhmh+E0qWKu?=
 =?us-ascii?Q?g0dF+r02C27YZvuWqiD+D1l2Robk0ijZ+6vus4zCYKtywi8zkopSCWIA9cR9?=
 =?us-ascii?Q?CZiIsA7EwtXlxXsf8DTBYJkI4LYWHSdAS4V4Rmg5e2hFlxh+RM8izrXJGSjZ?=
 =?us-ascii?Q?nzKoTXZ3YQOx35zjjr6EfKGk0u1NPKco9UFDpQlx6XEPhL+sQsh59K0AGNIr?=
 =?us-ascii?Q?RAxAdFe7+TA0rGcFcQeoMQ+vqoX7jDjtJqKm1PmNXKHLhEVkX+HsL6LnrbO7?=
 =?us-ascii?Q?fXxP3I3GC969p5F/lcfadRV+4s2OLGr4lYyu9jMTZahjIZDfOkOv+Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH3PPF9E162731D.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nsLb0IeV/SqlKRXv/p2ZVtbPFQpBSQGs12/Y1RMfj8Dw+1i7fBeljLGCZFv6?=
 =?us-ascii?Q?oD6ziAs9YcT9uUrYOxOiPLLaF3tvMrmde9FMqWVrc4Ki4T+uwAJSSAJgGXNc?=
 =?us-ascii?Q?KAfijo8cPNdMubrVkfBXvgKQc0KM9xwtrjhtsZf1Ok7Rek0VZPYWBMYp12Uq?=
 =?us-ascii?Q?BvDbBpzSA814xTvg69B/jGza+ikyiDiVEBTuyZDsd868iLCm1lBXaj9AQUHl?=
 =?us-ascii?Q?mzOY1IEol6Sry7q8gU08JASRM5iW33w2+skTx3lANhsSU/nC+oZUlqdo4Ol3?=
 =?us-ascii?Q?zgs/nd9LpFwoqTRBs9+RBQY3iVip0aTacR13hmXO29CyZXSy4NvIc7fd7zrj?=
 =?us-ascii?Q?g+hOJ3X7lFrqySItYt3eE6B9RgeCxudhMNll+GIuIQAwA+HR9tDNRM6f+eoC?=
 =?us-ascii?Q?jdED0Vq2j3gEnDDjpfnMDJoWDrI2ieUakgNRv4sWREg+kbk8EKbXNwsLFSLj?=
 =?us-ascii?Q?bQsXBoz/1u2kiGBCsyScWMqTVJFIwy+B0EeTR8YKq+D36ZBprOYtYU8/1dG4?=
 =?us-ascii?Q?ZC+VU2GErA9L65mO55QORvd9IyURy39rt+YkA1VmkGY/GfFSjp18tvtWG0oZ?=
 =?us-ascii?Q?cf2Mp6BU0/OrCCkZYAgfyuSUunklsBO74tExJZqUYVe9Hp0R1c6I7XGEVJ7R?=
 =?us-ascii?Q?ySGDvE+nke8OKnXoKiAJ35PL46vKnGrSJkbLAT3KrnGOP0f7nmiRFbOH81RY?=
 =?us-ascii?Q?QZIdnuy1yFpAqT89lisn7FQQjTsObCCDpLIBPMqkgl7lhxML2oR8usoPT3UT?=
 =?us-ascii?Q?95jBzQhs3opSbzY14sopgH0M85KotXQOVri/kP37VgY8pGUA8Yps5iTzmFyM?=
 =?us-ascii?Q?JKZD/GG+gcw0H/aD9zLvYsUCoCaQA5PTyLxkhhxX3WEWFu1K7WPOGWk+lZdI?=
 =?us-ascii?Q?hPBv/pX9lHcZwRIC/qIBkzSRMkz50IbpJfQ6HaQrbXUJY/A3KCHRl1OrnV4z?=
 =?us-ascii?Q?1abuFEu2HU8tVfkMxJrWtor/iOeSEO7eX6Mf6Kl+tqwvY4/X5XZS5GliS630?=
 =?us-ascii?Q?aPPGpqz/o1E786RQnVAJkV/Qnbi/4j1ZZDxbSeeNhBJltxEUikFicfqA0vjM?=
 =?us-ascii?Q?ad04Ah7xYCeliKEsl8eKfVqktKP1wVURdXjGcoGCNNTDh2+dO5dcy+L/0Iac?=
 =?us-ascii?Q?6To0Zyk3FcMS3KZ4Z8RNtlGg9BjZJJZpFvXCNukaSSygovh0XaU6eY9WLzTx?=
 =?us-ascii?Q?Auh/4IkCDCPUTE/3ieqN0uMSOlWi603kWf6PFvJd+SMkXd46maLrFRDkWiTu?=
 =?us-ascii?Q?S+tbakzpEOOqnpszjI1xXpnFtkExVDcWlEQiyrGe32ahCKfJ1TVjGuXa3o6x?=
 =?us-ascii?Q?8zF+r5HmE5S20UYe3bi2Prjiw2OyISpRccFjHg3sGrDLNq+47gBkJsoQkuRD?=
 =?us-ascii?Q?y10KCsFIP/UR03tryy9zv8s/co1ZmoTL9HNudoWJpzIPIYuHccuODvRub/KB?=
 =?us-ascii?Q?asgi5oWbJL0r1VNgBLTwaqfdjtbI3RAQU6TwiSfgnz0DKsR6Zzws0qEdjOe3?=
 =?us-ascii?Q?RCkWwPwhGZTyBTxhfXt91uQqpHR17fF30nglncPThsH/THZG5KXf4OdGNpLn?=
 =?us-ascii?Q?6HJ4uHOMa/iDuOv21VXFtksZG/Vao4/JMlXXLFuwwzA58SEi4zMWKliYX4xe?=
 =?us-ascii?Q?yQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 590e1994-1d5e-40e1-74f2-08dde0fdea23
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF9E162731D.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 21:58:51.7859
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kz6sg4Sc+I0YuyACwMp57ZqOxJg2vIcliP863ibZg7YCE0pNCLpdBbzCkH182DA9CTFrrmT21m1wmMh5BcdRHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7695
X-OriginatorOrg: intel.com

Sagi Shahar wrote:

[snip]

> diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/testing/selftests/kvm/lib/x86/processor.c
> index b2a4b11ac8c0..1eae92957456 100644
> --- a/tools/testing/selftests/kvm/lib/x86/processor.c
> +++ b/tools/testing/selftests/kvm/lib/x86/processor.c
> @@ -687,12 +687,9 @@ void vcpu_arch_set_entry_point(struct kvm_vcpu *vcpu, void *guest_code)
>  	vcpu_regs_set(vcpu, &regs);
>  }
>  
> -struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id)
> +vm_vaddr_t kvm_allocate_vcpu_stack(struct kvm_vm *vm)
>  {
> -	struct kvm_mp_state mp_state;
> -	struct kvm_regs regs;
>  	vm_vaddr_t stack_vaddr;
> -	struct kvm_vcpu *vcpu;
>  
>  	stack_vaddr = __vm_vaddr_alloc(vm, DEFAULT_STACK_PGS * getpagesize(),
>  				       DEFAULT_GUEST_STACK_VADDR_MIN,
> @@ -713,6 +710,15 @@ struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id)
>  		    "__vm_vaddr_alloc() did not provide a page-aligned address");
>  	stack_vaddr -= 8;
>  
> +	return stack_vaddr;
> +}
> +
> +struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id)
> +{
> +	struct kvm_mp_state mp_state;
> +	struct kvm_regs regs;
> +	struct kvm_vcpu *vcpu;
> +
>  	vcpu = __vm_vcpu_add(vm, vcpu_id);
>  	vcpu_init_cpuid(vcpu, kvm_get_supported_cpuid());
>  	vcpu_init_sregs(vm, vcpu);
> @@ -721,7 +727,8 @@ struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id)
>  	/* Setup guest general purpose registers */
>  	vcpu_regs_get(vcpu, &regs);
>  	regs.rflags = regs.rflags | 0x2;
> -	regs.rsp = stack_vaddr;
> +	if (vm->type != KVM_X86_TDX_VM)
> +		regs.rsp = kvm_allocate_vcpu_stack(vm);

At this point in the series vm->type can't be KVM_X86_TDX_VM correct?

So that makes this safe during bisect?

Ira

>  	vcpu_regs_set(vcpu, &regs);
>  
>  	/* Setup the MP state */
> -- 
> 2.51.0.rc1.193.gad69d77794-goog
> 



