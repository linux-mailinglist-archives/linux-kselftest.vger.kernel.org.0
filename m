Return-Path: <linux-kselftest+bounces-13346-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D776E92B189
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jul 2024 09:50:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BDFC28289D
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jul 2024 07:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 373BD14B953;
	Tue,  9 Jul 2024 07:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XL/gu/SR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707111509BE;
	Tue,  9 Jul 2024 07:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720511414; cv=fail; b=PcoJO/F3HaM6ZmI5q6q0VRk2VQwceRkuC3qptJv1U3LkOCks1OjOAtWeVkCG7352fncobkBB4DpTOAL7nhvkeDv8DY4uzMnd0rStSEE3OEioA4ytw0K1LcWgdLnilUtsF8szIdqsLcgc51YsWbrhWMAKzJLZJcwvHxBDstrDYCM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720511414; c=relaxed/simple;
	bh=f4T61X7B6G7ulUx4H1ybVwfTbNiSmlCTHztp8LJYWtw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZHBPwEAZmPy9xcyRIczPhYDfNm6AhfKnuXHaPoHMJW+P7dz1PFkC8W+f/PXS/Vb3Vv9Xydy4UxcXSFkLtzpwG0RRMf7eXnKIV4qMc0ZT0BkMpDOTxrK4tLfQHTFfwg44eiTJAffO/2832H+K+mXfjH9x0JGz8j8fJ2IxMZPzomY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XL/gu/SR; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720511413; x=1752047413;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=f4T61X7B6G7ulUx4H1ybVwfTbNiSmlCTHztp8LJYWtw=;
  b=XL/gu/SRh+qCH5jYdxlvIy4kUyvuZBWW59g6lVC3bO2VjosxV+LnxK2i
   c/XihJO4I2Dj/n4l5XK3rH8skk8NzYH1cJPr3IlpGgExhpU68hDeLH7sd
   VHb0K2q+XqoOI1EYmOo2D2JUmZKJmMV+ZV5TrRA4JHVYNtKvE2i977zEx
   J7biYNrGDGeNd7r6czcWWTo0DwHhtypARQORj6BHmbXyD3PA3A1L8n70m
   hNKRk6ZtBXMvmdSjxgNcCBu4SZai1cRGqd13afH4rK6wL0dUe8s0830Se
   rgzQivyBnVZ8JJ1Ujczw0cvX6RMcB5QzAzzpN+0iMBtUFDl4j7mA0Nn2a
   g==;
X-CSE-ConnectionGUID: TarnoRTyRPW7DH61SQUZKg==
X-CSE-MsgGUID: RVFrC4d+TYuxgszr6T/lJw==
X-IronPort-AV: E=McAfee;i="6700,10204,11127"; a="17379958"
X-IronPort-AV: E=Sophos;i="6.09,194,1716274800"; 
   d="scan'208";a="17379958"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2024 00:50:11 -0700
X-CSE-ConnectionGUID: iXZ5upmXRJyt0e9DQe+h8A==
X-CSE-MsgGUID: aQ0ZRxc7Sy63BsmaJwDCig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,194,1716274800"; 
   d="scan'208";a="48431291"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Jul 2024 00:50:11 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 9 Jul 2024 00:50:10 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 9 Jul 2024 00:50:10 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 9 Jul 2024 00:50:10 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 9 Jul 2024 00:50:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yb6usrF3yJQvKfZpyt85ybPwT5Ri3oKjc42pA5zKg6ZYaA25pfo/4RVJgVidbWLq2/CywOILBU6XPCul3mF0NiOdCbjZ9Ri0zBhQCqdrRiusAmPBvgi3vU0xZl4jZ9ykN7pYH9uEbL+psVw2vAUbxgHM080y9aY0hcXSZYWcvKV1sgu1DwWYecsgIOs/DvT9RymkRb4ssKQtmdQbM3IorQDX5acYNadOiRiM5zSSznHobEQrswkxCKlQeKFhO2x7yeng8B7RMJq/7SK9TQo1KmfS0jVcpVaTyVXYbn/06JAsYbNZMcjR9EyJuOWsfpAclQ/WPmltBCr7bLTnjiCAhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6DnB5yfjm/2pCPrYFR8xjm0d0aUZvJDBrieu2xdWsGU=;
 b=G9cKCFJvjdQjZL0CezeGIuDIfPIi7sgYh0dfrqn7iZueFKD7BkvJ2uSNCW4+C1NlVM8RLAFkC7c5ASe51jMIpP5wQ1PsldD8gvYP/kxXZ3gbgzD3NI9vzcYBMyzMxei2xEDgiSWmKv+aWfXhpZLXWsTe7lLXIEgs7eSmr1/DR90AiohnbgJz1Ms420dXkVBn9XxyNI/bo7lvHT2rzi5g6ouyx286bVFqTDPK4LHW01/6I+5KvvHz61+Z8QmHnRXsMoAkuU1Ll3kgTG7ot2IGR4kKxfMa943WH0fL8VtNhHluqM0KGygjZEtEmrFB3IQS6yV1gweBCBQ1nrQAN1I9xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by CH3PR11MB7372.namprd11.prod.outlook.com (2603:10b6:610:145::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Tue, 9 Jul
 2024 07:50:06 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::a137:ffd0:97a3:1db4]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::a137:ffd0:97a3:1db4%3]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 07:50:05 +0000
Date: Tue, 9 Jul 2024 09:49:49 +0200
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: Reinette Chatre <reinette.chatre@intel.com>
CC: <shuah@kernel.org>, <fenghua.yu@intel.com>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<ilpo.jarvinen@linux.intel.com>, <tony.luck@intel.com>
Subject: Re: [PATCH v3 2/2] selftests/resctrl: Adjust SNC support messages
Message-ID: <3e6qgkiefkytuq2vvrkownaisyzolc4d5s57ju5zg7e4uoiuvv@fjuem3gj2dtm>
References: <cover.1719842207.git.maciej.wieczor-retman@intel.com>
 <484aef5f10e2a13a7c4f575f4a0b3eb726271277.1719842207.git.maciej.wieczor-retman@intel.com>
 <c1ec4e04-20cd-4717-83ed-da6a55c91889@intel.com>
 <0b9210d3-2e47-4ff3-ac06-f6347627b0d3@intel.com>
 <d5bd6275-ab86-439a-887f-17c04a586716@intel.com>
 <xfhv744t2ol274w6lddon77rn5dkf7dzbwqcoknok4kk4guehz@hwjsusvhoerb>
 <fda4f2d4-b0b1-4fb9-ae0d-0a5c4c1b65fb@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fda4f2d4-b0b1-4fb9-ae0d-0a5c4c1b65fb@intel.com>
X-ClientProxiedBy: DU7P189CA0006.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:10:552::6) To MN0PR11MB6231.namprd11.prod.outlook.com
 (2603:10b6:208:3c4::15)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|CH3PR11MB7372:EE_
X-MS-Office365-Filtering-Correlation-Id: c556be7f-a2c7-4cec-258a-08dc9febbf64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?CpsPvUmaexZ4JAyxSDJHI036IFPEbooW0xPcpmfUgVpkLaHLz42BkLhkkZ?=
 =?iso-8859-1?Q?43gh2uf4wN3zrYYg0aoJ48Za3nyghGstg44jmJWKMOXInPg6uqJT1TMIiw?=
 =?iso-8859-1?Q?ZCoLZo+wg8GEqAfMUw1edZOYcVjmQQLqmxqSSwbtJRVMuyXTK/tJbH7SeA?=
 =?iso-8859-1?Q?OADEYL0YzXZGXHgHTX8ZcsGe1xzaq4S8GZIZCA1l8RqfGS5/1Z6KGmITKr?=
 =?iso-8859-1?Q?UYkVST7pnbZRMPUMsfhsxrkEvaUDiJ4UvFkBo8gUun6B8JB9ovy4PS+azh?=
 =?iso-8859-1?Q?lODnuM1ORFJAyc2P/bHm789cO5rgtUQnSsKoTzQSOKw9hBnZEpy6jByEnV?=
 =?iso-8859-1?Q?kKJ2DFtv3I42fexKfV9cS6b1+PGkxxCRowTYY+0SpDCfiMoZ1d0rQFvj5j?=
 =?iso-8859-1?Q?DQWtwpWmdNknDQRqlApZHouwxOc1IhND9xiQqwFBmIgkIcmun98A6bbsAx?=
 =?iso-8859-1?Q?8yLwoXqvTO6fFs/wOUtg/lwijAU7sOYZ6Re1pq85vv6oUitmRPLyyoGpZ4?=
 =?iso-8859-1?Q?Jy6atBq4Guz2MiCBYzhVbsL7nskx4GRPrmLnUkMEA5Teac0j5gdMV3smgh?=
 =?iso-8859-1?Q?Kennq0dGI56L6Nef2kHbrqP0MuuaNM0Ny/k294icIhoJHEhUTCED3vNjxm?=
 =?iso-8859-1?Q?yUZDbprXVxQiByqjmtMfFDKJ/X0JkDETrnBmaLHkGDsw6hLJMM+Md/bN74?=
 =?iso-8859-1?Q?ygp3KgXgUvrvdySagKiKCl2Z5Mh1GsstvVkavC/tRy3QeCY5T4UxGu0qBe?=
 =?iso-8859-1?Q?SplvAGESCpAW8dJSMTpEeV1RseflLqgp4hEz+0pauaYdRiYW6RE8nNjgWl?=
 =?iso-8859-1?Q?Fy4Si1q6OGYYqU0golX8Jh2j4HTZY20cJyc25g9529672rcnQ95tlGf9a3?=
 =?iso-8859-1?Q?2gZlG3bwtTxoq0+gv3LI5MkvDVMUOIwPUG/YrfAWho/w7UihxrkLMHKrNX?=
 =?iso-8859-1?Q?S3mqnL8miUg5DiQ628IYkAZS1MDDza017efS1fKzIQWTrWDmZP1qycCYjc?=
 =?iso-8859-1?Q?qZ2IFGnyYed4NohOVLgHKLIqgPdF9AqR503V8jhCAX2uMDK9V0yDMcaLL6?=
 =?iso-8859-1?Q?c6jzJKAtA+N918JdL9sssqu2vL32qY1grpdCQOqJToYuLQKzVlZf1s6JX2?=
 =?iso-8859-1?Q?4jj0KdiarM6hxVWNbr4+E/3qr9RDgbtx1cUH5Sztn2S8Q8UQQaDFUT7KZ+?=
 =?iso-8859-1?Q?uxcwXBR/sitzGPAWVMzQTmn84/NLwd/A3eCNyhNhoFmcM1z439lBeTCNSI?=
 =?iso-8859-1?Q?GmXBv0GoQJkqendNALcY5QAERp0W0FxuEJ85y4ocgXTwLy//Q/SvTvEAAL?=
 =?iso-8859-1?Q?aPDbF42CHcKgds577/sIJoinKB2ElO8FbwKx8zwX0MD6TLH2m8YLyo9WpS?=
 =?iso-8859-1?Q?vCThf+F41vEFOYth3S7QrUHlcJyysPdg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?WGv5khWmXMhpengZDDyWdhh0nHZVuQ7IXJkrldsWhXobAjDJBMaOo99Dk1?=
 =?iso-8859-1?Q?DDQC8pwrKYo9JhJoxn4cZTw9qaLONRIKWQJIQAZpIx4zr4ufvAtbwD1rnE?=
 =?iso-8859-1?Q?VpmTcgr1m2qg+hIW0Ef0dGBGGmQPVmp9LvynhM1WGO0bDhIAuVzWIAOqEu?=
 =?iso-8859-1?Q?VnNTBZhyTb+6ctAC9fZEoX/ePrDbGSU8j4lF30Cyr/iExIh0PdTtEBeS4V?=
 =?iso-8859-1?Q?SKs0Dp/rC87Z/O66uF3ZrKGBeGsGFF6noy7ZV5TI3izJT9Fov+8ecnwf1y?=
 =?iso-8859-1?Q?T69wE0Qq7RKqf6/qVMQH7kd5cgqAMMx66CUPI7FyCdCtQFmusdZ8LBeSKE?=
 =?iso-8859-1?Q?ZUAkQHVRz4nRD7ZVlk/ec4+SamNdmLooCVEjGvAuSLRAbSAitrxBCOfsAl?=
 =?iso-8859-1?Q?YxJ0QidIJ6+41vzVZSRdzXfhwdRi6B3jyzTJtnotyH2M3fekHOmXj4sreM?=
 =?iso-8859-1?Q?oo8NWYFl4kFmlWHfzSkd32584IhCBJCX5vKtGpQ82NLkm8r9ClFJC0o/3c?=
 =?iso-8859-1?Q?9TOr2lVCe25VAPVpJNWfVVvo7lVdjZARo09jxMd1tsUTkdcUcPEqcNZ9k3?=
 =?iso-8859-1?Q?laCAp9G+EvYkgx4d7TKBsY2WLlqmZcPONk/4WJ5Adko2jMmwBBzlNVR6cC?=
 =?iso-8859-1?Q?GrhZMV23lgIfZz4OOp75zNNWjvcJ5hFxQLv+V/LyHvQi4G1UGrj6x+t1ab?=
 =?iso-8859-1?Q?NhYGJNq5U97h/irPijlH/A/rkd/IWX7IKdzeKiOxLIEj1MTT0ORA0D9ViA?=
 =?iso-8859-1?Q?IYrM5yIDyIV7KiGaUDYho1tfujaSu9ZT6SupgoyyxR4YX+xW70VaZU+AtO?=
 =?iso-8859-1?Q?eBdr82l7/yOMbawzLQjdnjOygy2ulr1m5n0uCBPDG3B6i8sAcqoPKHPQfl?=
 =?iso-8859-1?Q?RIGsHUyiKDKI+Wrl2mJO98A6utaUFwPT5DaPlhH5G5a65NX4aACWXx4yOH?=
 =?iso-8859-1?Q?hrW+mQUS1sXTAsJs3F+cKqA2kIKW/KWzJrWRc/c98Y0B9jfecIKgll0tQm?=
 =?iso-8859-1?Q?eeY1jxnyKUliuLdru15R5G4HPnpfO2AWPq8nZ0dGOKu03xnMblvLYaUjSL?=
 =?iso-8859-1?Q?U5Ukbrzm5XxjX/m1GoIReUkhkNNygZke5Wuy60rguYjdg2wDFeS7kzwt8F?=
 =?iso-8859-1?Q?JoDChREhoKyeS9TrD7YMur2EODI6IKZhZB2LImRFGKjc0EnRtzhCxay5DY?=
 =?iso-8859-1?Q?762ZW5CNT5zhVZixSPLggln1nUQ6wHagfYODGk/ajzdopwAxHOPynxaZ0b?=
 =?iso-8859-1?Q?4sP7Y6/kTQej3Dq4YGJotNNEmw3uJq56XdnsLajKcNkpladPykBrwn5Bfe?=
 =?iso-8859-1?Q?sAM3D8UI/YrD2VcqdvVyKCUGZyhpF8HnAGs0zpbotIVL24yyPJPGuWtygw?=
 =?iso-8859-1?Q?+frPzt41EZzk4naMBLKHPsUj3G18gft7raSDBmotsBZZl9BKjCpdV1rpLC?=
 =?iso-8859-1?Q?6CjydqaEv9FRBEABJUPZ6r68GlwPHnRmR756n1dUPeJBRY5IUEP6QTj/WY?=
 =?iso-8859-1?Q?e/+LMd7bmM2C0W2F22P4Ly7Ual7hEvEtHfP3U9dmQQHZ+9IRht4ReeGITS?=
 =?iso-8859-1?Q?hEdMzCsRkfvMizfxULC/lmd0qOxddTwUnqeAcTVbhUaOVevzTN/1FoBC6m?=
 =?iso-8859-1?Q?jq6jLnfyEzNirVhzqDqTyW73RO1TKN6BT1qOlOGbEaEgEfB4+wd/rapIqP?=
 =?iso-8859-1?Q?JaMlq4nc6ZZGLC0uauA=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c556be7f-a2c7-4cec-258a-08dc9febbf64
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 07:50:05.8835
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /zF0VSXNbswWSTutVL8xl3PBHX6nOo/+H2LfMfwLAvi6wCNZDsMaYOrpWqax4LjPRdD3d5hZtEaTdSNTly6/mQSvNDqAEtclQzVcBQa1piU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7372
X-OriginatorOrg: intel.com

Hello,

On 2024-07-08 at 09:39:02 -0700, Reinette Chatre wrote:
>Hi Maciej,
>
>On 7/4/24 12:23 AM, Maciej Wieczor-Retman wrote:
>> On 2024-07-03 at 13:51:03 -0700, Reinette Chatre wrote:
>> > On 7/3/24 12:43 AM, Maciej Wieczór-Retman wrote:
>> > > On 3.07.2024 00:21, Reinette Chatre wrote:
>> > > > On 7/1/24 7:18 AM, Maciej Wieczor-Retman wrote:
>
>...
>
>> > > SNC might not be enabled at all so there would be no reason to send the user
>> > > to check their BIOS - instead they can learn they have offline CPUs and they can
>> > > work on fixing that. In my opinion it could be beneficial to have more specialized
>> > > messages in the selftests to help users diagnose problems quicker.
>> > 
>> > My goal is indeed to have specialized messages. There cannot be a specialized message
>> > if snc_reliable == 1. In this case it needs to be generic since SNC may or may not be
>> > enabled and it is up to the user to investigate further.
>> 
>> How about this in cmt_run_test() for example:
>> 
>> 	if (snc_unreliable)
>> 		ksft_print_msg("Intel CMT may be inaccurate or inefficient when Sub-NUMA Clustering is enabled and not properly detected.\n");
>
>It is ok with me if you want to keep the message even if the test succeeds. Without seeing
>the new implementation it is unclear to me why the SNC check below is guarded by an ARCH_INTEL
>check while the one above is not. Ideally this should be consistent to not confuse how
>the architectures need to be treated here.

Right, I'll add the get_vendor() check to this too.

>
>The message does sound a bit vague to me about being able to detect SNC. How about something
>like:
>	Sub-NUMA Clustering could not be detected properly (see earlier messages for details).
>	Intel CMT may be inaccurate.

It sounds good, I'll change the message to this.

>> 	else if (ret && (get_vendor() == ARCH_INTEL) && !snc_kernel_support())
>> 		ksft_print_msg("Kernel doesn't support Sub-NUMA Clustering but it is enabled. Check BIOS configuration.\n");
>
>The "Check BIOS configuration" guidance is not clear to me. If the kernel does not
>support SNC then the user could also be guided to upgrade their kernel? Perhaps that
>snippet can just be dropped? To be more specific that SNC enabling is not a kernel
>configuration but a system configuration this can read (please feel free to improve):
>	Kernel doesn't support Sub-NUMA Clustering but it is enabled on the system.

I suppose you're right, this does look better. Thanks!

>
>
>Reinette

-- 
Kind regards
Maciej Wieczór-Retman

