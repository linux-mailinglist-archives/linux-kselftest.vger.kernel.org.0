Return-Path: <linux-kselftest+bounces-38902-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3363DB24F78
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Aug 2025 18:23:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0C131C80408
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Aug 2025 16:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9D7D246BD1;
	Wed, 13 Aug 2025 16:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A2EHyacx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E291D54E3;
	Wed, 13 Aug 2025 16:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755101309; cv=fail; b=lOe1Oz3q6sM3VkJkomsSQBaxs4DCew/xoXmYEdmBUUOW0/tKM6G5TIeWYo4HIfJGCV0wS5yDp8pKGcvuyXEKQDk7dDGPCpy9coYpKpIaWKEajtZArxgx56T+YAqByx8WKhEEqrxMosZThNeKVY+w72fbRlbhbBEfCeHuAg0oSE8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755101309; c=relaxed/simple;
	bh=t6hmh7zxvkzkafh4e6ATAi7S1kluGHoS2+YFh9jlqHk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=J9nGXiXsC4zWr2lnpzdY+PhL/c6fkfaV76EAcMgFvzfTjpPa0oYbdY2vlD2ebQ/O1JSYxC9r0XcRQSiWM5sL6XSfR6LhMcTdEVww3RwEGnhUjS6skjFWr3gEO1NYSxloZmEfnc+S5VylxYzJQooO2OhcZgCh970hALOgp0wjwXs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A2EHyacx; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755101308; x=1786637308;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=t6hmh7zxvkzkafh4e6ATAi7S1kluGHoS2+YFh9jlqHk=;
  b=A2EHyacxZsNyvGqLSChcSiddNK5tu2lMOBkMCKqRahLtf3et6V5rvN+7
   6nHN6cB9J1NO5jbtQxcoB8VxVhveeigIKWOHzhJ/k1ktGO9vo3qmvPwqJ
   uyIJQ9031u137Ctgkzti2U3J04naz8d8hfXUaGefljh0hlZLbRVL2Mj+8
   qxrHTePzXUdMfwg9YdpTg6q4xVM+TtjcaBEnK07fEzAMHwHXaozI5vf7o
   cCqgOOHB1c8Z97DRh7BzAor5SRwM8vG9R3bsJ1AJ4tZQIFbQHRAaw98HP
   lE7o+ZfvUUfOGf0UPRC1UV2v0Z80OVBbiKa4aLFhN2ylTVBKiy9P2/bPN
   A==;
X-CSE-ConnectionGUID: S8wruGkqSKSgtGvyDY/iSg==
X-CSE-MsgGUID: 76iqcQFYS8+gjDt8bLCx3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="56426350"
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="56426350"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 09:08:28 -0700
X-CSE-ConnectionGUID: K8FOunc/Sp+l/+3v90Ejqg==
X-CSE-MsgGUID: TxmOnqhGQiCf2KpcAIf+hA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="165732526"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 09:08:27 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 13 Aug 2025 09:08:27 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 13 Aug 2025 09:08:27 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.44)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 13 Aug 2025 09:08:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rLMGZP5OzHJQO/RYrQSrqi0GaQTKib7ekGhsXKBVQz4Ze1OnjXGts86VE+p2xeXkvEzg659dH3oFrC3QgE2k3RmySWgZ2AjH1d0YujFuHd8op89EAqlM6InIuxDqrl3ipJtVsieayxnXTsDlz5+qv/x1yELw8XTqDZNkdYvz/rFBToWZqDLyqovSMsTzC8FLPcBs805uodJJyu22+p9arP7wUe6rruUKJPyWe3W50Na3lHg8KEJzqEQshgTPtTstfWh/YCDmOuGUc/nbtcNxdRR0G9MVlAEqx8vAsU3n+QFUeIu+g+7NajoQm14MllIYdPXbtwd3ywKy0jEurG8MXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qcn/hZc8OvrbF4JolnfeRZsI5Kk7T1C9y/zuzgdeYQI=;
 b=SXpkq+ny+JUoU5cdiH4p6IOFSWIuEF/BtYzU8k4/dMWxK7JyOLWIi/vM8upXlmQMPMe9LMY06fiZ1sudAhGE4BbYCtL4TUWPdkqzNmxElAW5FdnAKGpOlNlSD2AbMqZQT6ucCwa2QhhC3BbrbC80NxCsL4KHiyGuKk1ilHiyB2GPPN0psX8z0Z703ds3cAabazv3EH1P12c32NOA5wmI7vgVy2QXll2F+Yx6aVNlGveyJhndTJapWLL6muY9A64HtjlNBx+Alv2thlwn7VrQQ0UHLR+teJ5n8UX2pvYHdPkcfkAmMneodmCn3i5GuMuAmkMNSy5CgUYFWhKTPkebzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c) by MN2PR11MB4710.namprd11.prod.outlook.com
 (2603:10b6:208:262::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.14; Wed, 13 Aug
 2025 16:08:24 +0000
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::bbd5:541c:86ba:3efa]) by PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::bbd5:541c:86ba:3efa%7]) with mapi id 15.20.9031.012; Wed, 13 Aug 2025
 16:08:24 +0000
Date: Wed, 13 Aug 2025 11:10:03 -0500
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
	Ira Weiny <ira.weiny@intel.com>
CC: <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>, Yan Zhao
	<yan.y.zhao@intel.com>
Subject: Re: [PATCH v8 30/30] KVM: selftests: TDX: Test LOG_DIRTY_PAGES flag
 to a non-GUEST_MEMFD memslot
Message-ID: <689cb8db46492_20a6d929493@iweiny-mobl.notmuch>
References: <20250807201628.1185915-1-sagis@google.com>
 <20250807201628.1185915-31-sagis@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250807201628.1185915-31-sagis@google.com>
X-ClientProxiedBy: MW4PR04CA0313.namprd04.prod.outlook.com
 (2603:10b6:303:82::18) To PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PPF9E162731D:EE_|MN2PR11MB4710:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d41b146-9436-4a18-8717-08ddda83a19b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tXdQLTXZvOxiqfHbvdQnUVxZ5CQk/TlHEmnG3URkdP23Y4ng/8cbevSRHob4?=
 =?us-ascii?Q?oiNz06Krb1cGjiM3htM7wHsxEQPOQ9rGoh1IckLPNY6KIgDDSSJGNFHWrZWQ?=
 =?us-ascii?Q?08kUWSGS4fo+5CCAvUEBJ8xNAqc8KFBuKvMMzT0Sky0zhtBDCW84oMBcboXq?=
 =?us-ascii?Q?/4X29ymBJpd9uLUCK3a+Kmg2Boo7SZs2ZqO16/ITDq3cwCgTWqTuADJuvw/P?=
 =?us-ascii?Q?/e40Ln5QEbEYaW38v/YtWpM7FOy2lBa/2TD6cQWQSIG4eR1OvWbWhKaPAokQ?=
 =?us-ascii?Q?ZeDTuHxVvVY+9qpftF/8Zx7uZygN6dfC2MAj/srgAdIsvxg9n9R9d1mAeGkS?=
 =?us-ascii?Q?d8nCZpNqivAJPwA8P1p/0sCaPHwbS5AimM1zole69BL4wUXfE675m2NG9knU?=
 =?us-ascii?Q?fKnugxSZsdckPYqSI+OsDq1V5wA1hF6QjjcD8f0CFSntUPkLXBI+RrfA1j1O?=
 =?us-ascii?Q?mlpVNW6v51LYs6bei/MLqYIZ6w8K4QzjCu9PkuiA70+GGpt/uU1A3TG6YTR+?=
 =?us-ascii?Q?ZmX3KzP3l6Z2ZwkCodwbym48P5LRk2vLUZs7eLapE+5tgGyE63tirbfEQVgy?=
 =?us-ascii?Q?6APHhH+WS1vrjY4nmKaR6JDDAF/jZCtxQx+WdSrzQ9WJdEiLTcut1Ux4pCH4?=
 =?us-ascii?Q?hJu/4V4VY12gRNhKXmLY9ijPqEcPSrbUfoAADIWQFEHO2PAIi48CwpH4Lkr7?=
 =?us-ascii?Q?MvIvLvJ5rMHMyqAp5GObn3Kt0cyzuiRp9NlrmKbVxS77LAgQIKQh2XVc34L7?=
 =?us-ascii?Q?Q7OGeOOK6/Maoml036RdWk40mPKaLBcj4QUNQDcO1VTYfCNKZmpucofrCMwE?=
 =?us-ascii?Q?uysx5rVemVA1gBg6rfA/BUcqNY5MNNsL/mn+X6DmltsBRnJ1ePlIOzSRttiA?=
 =?us-ascii?Q?SPU99s1kOCau5UDVFrYSY/DZJP7XR2Cte/YjN/u7L/rcKHC1I6ogHJUSn/gl?=
 =?us-ascii?Q?/kNZdt6phZcHMjRRwnw82fL24tqLtm6w/vT9Ev30JOzXjKfoGjncqeD6QOdV?=
 =?us-ascii?Q?l57kHAGCOA+5pjHfqEDnOhFOHcf4XRyNwIQLVpKsoAtJArXitmTrR9z/VCtG?=
 =?us-ascii?Q?90UEbJU0corxvK0SubYo7C54vTNXmKcrIktarW7aNQ+Ywym45gEmSU7Vg+W9?=
 =?us-ascii?Q?4uxjGLTuexxHwnQBDnzLpXynZG5fMkSr0TPVORw23U7Wp8vvlxvof769fynz?=
 =?us-ascii?Q?fxMxrbTgB4tmdX9eT4Ktc4/kD4Jzco149rD0g6Ku26qadDuMFC4wMRPIOSUC?=
 =?us-ascii?Q?pkeFHQm8LbReCqWxlNYFs5FtfJwPwE28tRhSyT0HM2QtaTnMyGOuOHJwf5c7?=
 =?us-ascii?Q?IR5YL1P4VN5upq3yI9pnvBA8RIPrtPLwjqzKgO86JZdC7+fvmk6qlE7SNmYE?=
 =?us-ascii?Q?5MLvjTWpQbSl2erzhBWQPpVmriIw/mX5+6wtTbCZKppJBeILe5BGrOfv5mvg?=
 =?us-ascii?Q?EeLYCtYfFnOS9KFqDdgHBS4zi2Fclx4PBAUCTodJyRJV9Tr1Xzywmg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH3PPF9E162731D.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IAW55toQsjQD5dVVICGzd1LAecooObug4QFwpLcgd63cMaOGjviTKTxAtPhf?=
 =?us-ascii?Q?237LvkfBDv34Yh/86FZBeYtYDx0rxoQbh7tYgKfqT/66K325Qpbt328UxaBx?=
 =?us-ascii?Q?Ew/Hrfk+h7JEEs6iPaL2yCdNOd0jcBsM5V6uN1CXy+1AFn6xESh4lWaVKWJE?=
 =?us-ascii?Q?WqxWJgQvKgOFZj4MsMPUKPWKrfqQYQR1bpUpm6VvMwBXFjaU6l9jULSXbiCi?=
 =?us-ascii?Q?0UQ6DYSVUgVaY0L5zVYA3DoavAhPsRqWRgAPme0SXl4FnzXW9c9+j5fWG08Y?=
 =?us-ascii?Q?Z/GfYmbBbnGPoGx8tMY+Z7zUK15VkHvxh+6VMIqec+7Sc+noNdnq2V8Vasfp?=
 =?us-ascii?Q?cuuVhidpZIAzEpqd5tkmnnZH0uWOv7faLY6Qm+LN0U8qb+R+qxtraWfcheS+?=
 =?us-ascii?Q?UoIP1ODxtHfRzAXC2vM6mFXB8MCvbEK77lnBIg6xQnHu5eV2zJnaxh04FCea?=
 =?us-ascii?Q?jqD9gI8bQQwnN3x1tSlmqLLhHGeGHbkXz1w4tIWgbbCOEXSOpUXXuPcRLyUm?=
 =?us-ascii?Q?NHklxge3wSsSj++V3Q8+JWy9hPkPWztfFJD0UhW22wNn/HAi80Yct2A6MatQ?=
 =?us-ascii?Q?JWauPkssqIckv41h9q6Wtxwn2Hvl6Koi5Uibz0tMO9VrT3KF5rBWV3bZKOKi?=
 =?us-ascii?Q?Ny7fV4pLQtYM+h0E5cmXW2I+ljrswX/rEjZEK1+RivOgDOAc5FGQy183Gz66?=
 =?us-ascii?Q?Yh/xYuAKho7MGBRp7At/KFKpseihF6TaNzsSmriqk4gu+DjpKbxeTyzaIeBl?=
 =?us-ascii?Q?cRvx0GqB+OVexLIikOE7QIyHAsnTfhHg8RkyxM/gBOcPSgHjWZOics2FJtJH?=
 =?us-ascii?Q?mBVJHHIvZYeHstyXTIAjD9VjqrL1lB5lDCMiPk/5JXdiw2/VeHv61hD8RKmQ?=
 =?us-ascii?Q?jlLTkA/rPPi4JgmbrLg7DEnN9X1Es7o5WboYL50ba2ojG1HI+SjoumomcIEJ?=
 =?us-ascii?Q?sy8chMy8DYdfBOjzP1ifvKzje7Owb51Yue0v/+24iJF3EfZmy8AaMtnsIE5e?=
 =?us-ascii?Q?+01JZkPxB0yuvO75nJVWN89Do2sCZt9wP0ArUNLQNmlojN2JrLyXM2bdFELr?=
 =?us-ascii?Q?sn84jP4qTFRLdQARoquGcPT9ylNGXyxsDhjsIojRlq+Jax+gPVN19I9KfJm2?=
 =?us-ascii?Q?oBO28ZXfNZwPArSIcwq9/XIadj/YW2KEBEd0E7JPZRJysl+ejaRCt7x/HSAo?=
 =?us-ascii?Q?4mrTELY4MJwbnaz5nBT92qss1XtpJe7E8+NbWkBJkgW9u6Fq4TsUEQuTzXFk?=
 =?us-ascii?Q?VwMyGRWE/Lx9iYxZJXmo9m0pFftNhira+rusVvzRqMcpFwcPAefwOq4gsGQB?=
 =?us-ascii?Q?kT3GiW4Io6egnFJ/5mSYAAqKE4Q2K4UXcnlpdN5Xt1bfrbL3g3VbPfkj6i/J?=
 =?us-ascii?Q?3s6tffzc+k7Evq3awa1v8+3ttvjrzeSmAhEV31kuttM06GbkUdk9B5JiKLly?=
 =?us-ascii?Q?3NJ0wOzjbpXt2ngrKKAkR8FhdLdgB11GjjgsfbQkqBDaNWA+l+dOMWTOaLbu?=
 =?us-ascii?Q?8b01nrxjg+rdyzt7tWI7cJ3Gc75hOyeGJWA2VSMbZ0JiQEYZhYGDkRbLvN5N?=
 =?us-ascii?Q?n8yQEv3YDbIZbLNivtY5PXAsjKaMFXw+7c2SCwMT?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d41b146-9436-4a18-8717-08ddda83a19b
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF9E162731D.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 16:08:24.4863
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zCBHez4ui83LD5D2EE+c7AfTY4xogJOufPgtxjHUevbMCMqDg+I2i32M/TzQC3L42OCSc4T5pjh1ToKmBbkY4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4710
X-OriginatorOrg: intel.com

Sagi Shahar wrote:
> From: Yan Zhao <yan.y.zhao@intel.com>
> 
> Add a selftest to verify that adding flag KVM_MEM_LOG_DIRTY_PAGES to a
> !KVM_MEM_GUEST_MEMFD memslot does not produce host errors in TDX.

I'll pick on this patch for a general comment in for the series.

Most of the commit messages are light on the 'why' a patch exists.  It may
seem obvious that adding a test is to test some functionality.  But that
is not always the full story.

For example, here it would be nice for folks in the future to see what bug
fix this was testing.  Then if it starts failing we all know where to
start looking for the regression.

Ira

[snip]

