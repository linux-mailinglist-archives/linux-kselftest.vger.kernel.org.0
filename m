Return-Path: <linux-kselftest+bounces-44249-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B7972C17EF7
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 02:38:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D4BAE4EB527
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 01:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40EE12DECA1;
	Wed, 29 Oct 2025 01:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jhFFWtsw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7843313C3CD;
	Wed, 29 Oct 2025 01:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761701909; cv=fail; b=HBwNJD74HFizvIdYFqb4E475vYTKWL1ha2f9RfYF16WST3J1JxtVO++/DuuQQNhiNCyIYtvh6O5AWJtfm46Nj7JYItb6Qtr9qHxilU96y2FpXGOTCAujcZT/s63218tdn4G4F66PT+CQXu1tYhj3hm387K/GvNizu6raHz5yF9Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761701909; c=relaxed/simple;
	bh=s6xUUobMf9HhwLJTec7ggn24DI0Ejf5lykOBzAUxWBw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EK4W3qu8V0SiYdFPPU00M1e6QoFZjZj1WC6QoXV8bAq/L9RQp9TJ84k9ukrOxYQZkNR1ROTB14cZXNhJeES3fB2KVbyio4L0sgOPo5t2kcwIwClCI7plVoWc5LjbDSOg/rcRX9lfcJhwPUaS8Lajzlh3HYb9uYLu06ngb9TBKxk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jhFFWtsw; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761701907; x=1793237907;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=s6xUUobMf9HhwLJTec7ggn24DI0Ejf5lykOBzAUxWBw=;
  b=jhFFWtswzTQY3x2CzbN7/uDgZgXLg/eBwNhVSeA6QfYCv8yN8ojCqxyv
   oOKpZTvmSJh06JhjXcfGhlPAiwRigygRlS8D+uYVJD0wvIiITAslggSYV
   m45QtOh+sOLXlNr/hhuBR79kb/JnJy9f88mpRfoudB+qQwrK7TB4zJZsO
   dID+LHklUtqJAIwko4HQtFgzG+zdUj54BZqtL8/RafNLYtnYCg8ddsv9B
   /b5zFmXHAwpBXGTf3gAc/4yga1w3X404kvr7G1s0SbjPhI7BytKvR8gIO
   3Z0Vg0o8W9df77sjhFhuoZ06NoRSG4Dnsc0iaSk3rNz2V7vqpCgZ4zsKu
   g==;
X-CSE-ConnectionGUID: VQ7J1l7vR8yPQARMENW5+Q==
X-CSE-MsgGUID: rUWk7g0dTm6MEx3hD66TzQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63963093"
X-IronPort-AV: E=Sophos;i="6.19,262,1754982000"; 
   d="scan'208";a="63963093"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 18:38:07 -0700
X-CSE-ConnectionGUID: gu/K8me4TjSkhTggilqmUA==
X-CSE-MsgGUID: o96AW65aRo+UoJ4ltbJxbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,262,1754982000"; 
   d="scan'208";a="184703160"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 18:38:07 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 28 Oct 2025 18:38:06 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 28 Oct 2025 18:38:06 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.35) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 28 Oct 2025 18:38:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PsxZo8NY/5Ef261q0gl/XqPBFVk1UC9XJ3hpQL9U2cTcRKtqWF+lNLWMeZvRY6uSqdWDggTcwkAWZJyTJbVtHnGCbeQGyDGhSmYQCCvdJ5n2LQJVCW1dkfbzmUSsa9S+FmMGYrI9ZOazOhSKwa2uh2kfKWc0mSW6d7qOVgQY6KzxGZXck7vM0cEe9cwyJYBGES6e42sw5Mnk+XsaAgrLYeRj/NTlD0h0+QBvrlzVoqUbyh6GE6y9GZNIengH/UF8yMBp/D0qp6wJXgcSdoPQ0muH4o19yz6Z413kNcIsiGUFLiKZGwvQfPuRhgvWgMDrlzEScAvPOCliDPDG4b+tkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uiqIWeq1zm6qddtzJeEgjQs02kYAVAEW2Uiye45hsMY=;
 b=BcGQaboYqqWXPV1nCYiXCD0FbiCQsaHjKqAdMPIQB0z6d2ms5G7oRqf5sJY5vBE5s+us12NIxtlDbkbDTiqUh0G7IG+AfAzpGOWlnqsr7gbZhQ5rfbM/McgbpjxlHdGYazrpdz8l1iDAUdrB3AHL+kdJbnDzrXy3XIkQzinZuZ1Cp6bg7ZbwE0cmYcfguM3mEgW1nnJF6M7WECsXYmfAJwlxUUHp2g4KwDhTfiN5ClP4XoGfuoAsNK8Bef8JMo5767IISxxk0S7mIxNfDiAEI+dvvVDc1EelMolcFKe9j+OD0DZAWF59OaBiW+GNO+PgnYoKSc5G/aB7czrTRs54Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c) by CY5PR11MB6209.namprd11.prod.outlook.com
 (2603:10b6:930:27::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Wed, 29 Oct
 2025 01:38:02 +0000
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::8289:cecc:ea5b:f0c]) by PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::8289:cecc:ea5b:f0c%8]) with mapi id 15.20.9275.011; Wed, 29 Oct 2025
 01:38:02 +0000
Date: Tue, 28 Oct 2025 20:40:20 -0500
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
Subject: Re: [PATCH v12 03/23] KVM: selftests: Expose functions to get
 default sregs values
Message-ID: <69017084d464c_206050100b4@iweiny-mobl.notmuch>
References: <20251028212052.200523-1-sagis@google.com>
 <20251028212052.200523-4-sagis@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251028212052.200523-4-sagis@google.com>
X-ClientProxiedBy: SJ0PR13CA0068.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::13) To PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PPF9E162731D:EE_|CY5PR11MB6209:EE_
X-MS-Office365-Filtering-Correlation-Id: 63a52468-05ac-4e3d-8067-08de168bcca7
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+ClAFBPl+dOotCrvWVyTdxcyJliRzO4SPh7tHG8nXS2qD5F4PA70KLVh9mkF?=
 =?us-ascii?Q?rrkPFD67Y2IEgPwE9Rp8yK0ykbrUOrIINKAz5nsWRuc9W4j5QdjOK9HIyQDB?=
 =?us-ascii?Q?667XYuPqz1myRTW5cb8pMbPTmKaC+gFkzwrfRpQfDvxLeQjrvvIapUNZon4G?=
 =?us-ascii?Q?FrbJnz4B+tlfeP9p6E6N3BRjoAUAjQcg/n6hs2o4I4Jge4KXdGcGTDy/kefR?=
 =?us-ascii?Q?7O5trGRVu8QJOXzhnu9EcdUmztg30B6oJwRtxVA+gYH/qmyxQGnPn92HYhtu?=
 =?us-ascii?Q?XpwIavTov2hD8cn7Ag9JJqwf0S8PrducyjOIAnukupwIYT3A2+cKZX2GeSxw?=
 =?us-ascii?Q?aEeHIu2RNVAeAmUQnFNgJ6vuorgznB1jth345S7GzM4KmHul4YdMJxBLnoiD?=
 =?us-ascii?Q?dmo6D9MPkgtZpDyN/0VLhxTcbcMXJhPAEOIKxbXjB/mWCc+NP2HjZW1+W+IQ?=
 =?us-ascii?Q?a6uWSPkzAjwd8n5Xl8ebnU36bAOnFYVVysH92MNxGQH2B0Yv6TUyjVUrqDUG?=
 =?us-ascii?Q?f/hedL1if6uq7bHILTgIHnHph3FfbsBx/xgL8gLnGig2UgfaSCAuewtb0Yaz?=
 =?us-ascii?Q?BoYeAUln2DxPzMdHheSLpUZHO5vuiG6XUlzDtwOu/p3R7q0NME2hTTITNlOF?=
 =?us-ascii?Q?jeJH5fjr1Ere/EMNp4cZvD6ZABSE8aitaHqjVZuGQ7BmzjmCCmydhf3fkm6u?=
 =?us-ascii?Q?sIHTRj10ASMdOgxqzHcaAZ+HDDUAnNW0webpSaKt0aMIEbNoBfvIkq+nj3bc?=
 =?us-ascii?Q?4/jqLsfqEMjTXp86dSV4fnvMPib73JaV4vCtttRmrNl975lGLWgVJd2Tdafn?=
 =?us-ascii?Q?VWyq1JQnQhsslfdPoiMpdqrCAkztIthb2gZOf14tuA6/pkLpcjMhrim3pD5P?=
 =?us-ascii?Q?Jc4pmux7E8lZf9dAFaoALXB+wlNlHqexoKNBSWpvK90eTTTVLUSpxMbPPLgb?=
 =?us-ascii?Q?rH8HatwqxuQS63PJkGvHEUJ078OOfL+yhjgTA6hnIDDUnsh4nkwfPJqiRPX9?=
 =?us-ascii?Q?UR6ZO42v/prAICKLRkiicRUQFeyjEZckSTScm3OSW5+xhVMO5ky/2mEFrfRT?=
 =?us-ascii?Q?y0K9TKSjeDMnDV9xXF1XF3x2kR6EdCrm28K+arR/OBHYUecPhd/fREQUP3lQ?=
 =?us-ascii?Q?1Du/qTLyEB1pxGQqLgGw0yDOsfXiEgk9p7VdmII9c4sHanVXLZdoxH9sbbSq?=
 =?us-ascii?Q?qlwMOD+D/trdzec4/SwQ03Bnj1SoRyBVbZInyN++4eO7GfkcWehCfASRiH9a?=
 =?us-ascii?Q?JEHzAMRdTSb4CsQBwypG7AvYNqQACRaYOJkRXoxweON9/EsA4isyjE0+eq2J?=
 =?us-ascii?Q?2wlkN/9x0aVAIOXGxCi+i/vNrkrfz45sn4c26roIVM4M0XgAHqnCkLgM0Pky?=
 =?us-ascii?Q?2hOe87HWLYPit+GB8ptXlxCFVWAY+vPMgCQMh2e4YTXDZvy8bxYkF2VC74vW?=
 =?us-ascii?Q?rtYuUXlpqPZ39QJmwQ4jskldFzcb7XI89SrVCKptwYzZbgIizcoGDoxkFDlx?=
 =?us-ascii?Q?DXkocv+w/v36abo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH3PPF9E162731D.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OxEWb6W8cZMUiByR2Kx9PT30Q2Y9mqS/vmT2chxZeO6NyOOpJLfDnF5uivpg?=
 =?us-ascii?Q?jO+Qvy2CMbP/eV8j6X1+r6zXrzgS5y6RwPtdJO3FM4OPB1xhe5HeZ/y1WRsS?=
 =?us-ascii?Q?+j8C/Ad8MAyAL8D2FrMxzkc1ymca5m6XdBQAaO2hhUWeelto3XN9B6aOoxdI?=
 =?us-ascii?Q?3p6RIevECvI6MTz9yAGxRRLEUEQ/u1+JWE6U9rXibMfaoO4mlnsV1oIA08S1?=
 =?us-ascii?Q?gPG3orJjcPWRMGsTXZFijVZSjBIvut6PE8MlxT+ThSTrHbXKMm9I9P9eYGT0?=
 =?us-ascii?Q?uL3wO/7+R1Xng2DBb3079rrGN18QEybPuKoeUSQxSpxtMmaKB+uIcnEH+kR1?=
 =?us-ascii?Q?OlSUYEbnHPyap9jXNUaYcXqCnvJUAWam71VgTxoopiTMnQOxTU+wJPcumj1Z?=
 =?us-ascii?Q?f0SJRDiko/X5PN0ht98Dqn0bGWI4EcHad4gIYb0PrgERu81kjh6wgIEz368i?=
 =?us-ascii?Q?yTVnQZc/ivx9SVgJBBeGFGQiW6vOUk9jfOsBtnxhhYlK4bxb0qlG1Padu+Vr?=
 =?us-ascii?Q?soql2D46kJE8aaR1U/Sv199t/y0VT63lbIPIEmjYtxOimP9A8gJvYEeMXwor?=
 =?us-ascii?Q?0tyz58wR5gw2r3fTkqJ6XAtPXeoF755uhgPdjln9vcYGPFJ2pFYKk4/OLO8O?=
 =?us-ascii?Q?6Q1Q4Kft3S7BVSQ+4UGdnMxpNnG1KmdFBL8iHx05uB2lBYGDtQx0n3Ieb26e?=
 =?us-ascii?Q?47cjpuOE4QUW94+yhZbElsFXIfgutJqJ3ib55QoJiupSNh2sQRyEmyNAU2Eu?=
 =?us-ascii?Q?JoxtRCRUJWCnz567TP5nNXZGBgQsvt/xWysCRH04ROUKl5RcpYviYQAnQU4I?=
 =?us-ascii?Q?4QylcGg848p2IlayyCV+SdQsh8JlVIQso/ov5Ksl65M8SIpcEGxrPD8B+4zO?=
 =?us-ascii?Q?GKem63dYJAIVyXhKtgbaEF7BbdI0uuK1CQvPwtNYKJxUB2SEurIsPpTv/XwE?=
 =?us-ascii?Q?81QnqC/dg8o495g1+8xKg3zZH92CiyuWCnIK3E0dO103ArKDKrTbT815T7LI?=
 =?us-ascii?Q?lcFvq+76QnAYaK+jXcHUt1bDChpYqWWW+Mn9QQIqzt++5iPF3jlDHjQY4WMo?=
 =?us-ascii?Q?j4BnWFcrFZw2LdhA+zyNYJGYtwzAEsXfUg59KVtiNeYHFnf3Q+BTFn8fI46Q?=
 =?us-ascii?Q?R2mCPfaJT56rFQHfm64QInZXRZlADGgD32zIf6l6GZpQbdOIsnSlbO2vBFyG?=
 =?us-ascii?Q?SRdNLtNMHrRPCRErgaJU8+nAFi/Knhle6/uN3GbedkDe9qOdGn3EaJiF0cWZ?=
 =?us-ascii?Q?QWq655SqlbvBz12n2+GntINsOE7Tq5Gi8T859B2aeWpE1PyKq7IK+JSclbqP?=
 =?us-ascii?Q?8TxfZllNafrWIensaPWjCAaPw7L1cgS1HrVBmA4QGeefqy7OEa4TXrhbvzBI?=
 =?us-ascii?Q?sq0EWX0OAbQJDbRW003eB264MoQsoLJw9NjtcejaVEU7aD1EfiQT4SCroSZb?=
 =?us-ascii?Q?ogTNg3EhB/fjMYKNc5xoQW1Qqkw6rt69BJoBXsPWNQyIiO4i3vrYJvzzDQr7?=
 =?us-ascii?Q?t+zuhkgWfjplfwy4KGhBsnG4+tQq0IbHiB1brSH1d5NaRtLrDUMqBzwkyE7H?=
 =?us-ascii?Q?aXCgaLGxMDFPVImdbQ7qd/QhOE5z7bNzQOjkThlM?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 63a52468-05ac-4e3d-8067-08de168bcca7
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF9E162731D.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 01:38:02.4631
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K6r0zJTCY/nWJ+916DBalBWJVVYYBJyxTkuMpI/V5c0jikG8lyLkgXPetwJFT3bxYsSKYA4qJMrZIWAyIXgg4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6209
X-OriginatorOrg: intel.com

Sagi Shahar wrote:
> TDX can't set sregs values directly using KVM_SET_SREGS. Expose the
> default values of certain sregs used by TDX VMs so they can be set
> manually.
> 
> Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
> Signed-off-by: Sagi Shahar <sagis@google.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

[snip]

