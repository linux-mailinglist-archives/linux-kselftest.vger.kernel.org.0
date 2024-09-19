Return-Path: <linux-kselftest+bounces-18134-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 357B897CB20
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Sep 2024 16:43:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 670021C212FD
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Sep 2024 14:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C21219DFA4;
	Thu, 19 Sep 2024 14:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gkmht2n8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B8C1E517;
	Thu, 19 Sep 2024 14:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726756988; cv=fail; b=COAdqFD/66YFGb+9QA/kl1WT6s/D4Diy7EyJAontsDR+LA2oVHNMioNhjr8dG9Vq5fFLnYa8qMtHnBZQUWLloSunsROg/ff3JyGCtrCKbZZ3aVH9/9hlTu2uRo1wDQiLaCyf+YBOn3KK6ifozvDdPA9q/drdhgFgopXgykNpTHQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726756988; c=relaxed/simple;
	bh=8mmya9QLI7pSyDbJGci1SMxV1eZT6NTOTqMKIA2vq2A=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Fi4KrO/90A3+zYbqm4fW8HB0ClfZdSuFsjU8Zwdr4ca+P2722gOKDImNCtMSBx19a4PNsQ8H4AlPq/2aLiQdeTLlagLpuHre7sk5rq7aLCfas8N2L4jDvuslSnFbPn7VczkB+MmaAjbfdbI29TTuTtEm+n2IqoA3nxPLg6x5jHs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gkmht2n8; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726756986; x=1758292986;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=8mmya9QLI7pSyDbJGci1SMxV1eZT6NTOTqMKIA2vq2A=;
  b=gkmht2n8i+zWBO01/uN5Cwz93aQTNm4X7W93Jd3xDkaRxEPf0xLI0MfY
   2Wnm8ua6zmRWndM5S86uOiMEqPDFQ94sKscy2m70pu1L+3zpH/Q9P+Z0C
   Dst7eAuFWtKxxCEET+CVFhlqzGywLq+/TT1loyEnQDF1vVvAYEzNzQrvy
   7xOq2/khuQDWY24w70xnFryYPjdXj4a5/75WF+tFus9Jr34QpbAAWYHH3
   ann+F8quXw1FDitz4MCir8knL3MzR1aNNq4MMOgYgUrm8voBX9+gwNRMg
   ainfxQ5VQztp2tdIQm7t+FsRLYdBiaFZoFBWnMQz/FpKpvDdClakjIxek
   A==;
X-CSE-ConnectionGUID: 5rlWJuEpToCDFIoimsP8Tw==
X-CSE-MsgGUID: FDIPtU/uRcyJIg8IsHalWw==
X-IronPort-AV: E=McAfee;i="6700,10204,11200"; a="36296191"
X-IronPort-AV: E=Sophos;i="6.10,242,1719903600"; 
   d="scan'208";a="36296191"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2024 07:43:05 -0700
X-CSE-ConnectionGUID: SaG1uv4GTIu4Dp1sFAOsjQ==
X-CSE-MsgGUID: WeyKUm6FTUKZLlxw3BMiyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,242,1719903600"; 
   d="scan'208";a="69549977"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Sep 2024 07:43:05 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 19 Sep 2024 07:43:04 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 19 Sep 2024 07:43:01 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 19 Sep 2024 07:43:01 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 19 Sep 2024 07:42:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=urp5nJtRE0tiBRv2oroHaRuDax+sFpUtnXEJgdkV/g3josMxImQDVyJR2E+FrO3v4f1CP3cJVdjuNFRkO0D8Obn5pLfbokJo1yjaZUMlaS2bpS/FIhYgJafqqOTDKHtI2lOxW0sfRSvPiORbxXnx1swVF7G3dOmC3hCmojk4K+H7ff6+Yn3UddpqhB5Z4aYg6ygaGQzV2U23FmrCKEFl0aAVW7Yt4rGPAaytV2qcJmua+cZrZNlmGVjxi/hmEANoTf4f3WHNtO2kqd8GjPz/oIGF1kMn7PVWVYsd4CZQ56tXhEE87BGXo5JRiqcE9UEztprIt9LnS1HsEGLpUVTR+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TnplUBD5i2DSxkazE10+DOC2DR86WPoM5Z1wDEhvciY=;
 b=ce5Il2XyWoKGUdqeQn5bTH6KPnkO/Uh2wSJNOLojzFQeCKT17oQYIb6rKVHperNNs/Zil2Xwoyva1hxtDeADOWYTP/BtEj4qa69wTF3w6Jb2jn8SIVRMwxHl+G6XaD4F50+o4/0dJ4kiuvATV6VJI47JpkIPt4q2skao0NJcNfk021XVFzVkWq0OLd0zpCvH3Saqts7SH8oHPlvP3mF1+J15TjV6wxAlW5OkfKl+qtkeUgEHre7yY2/L8jotfw6Ow+JvBYgSWuDyQ74U6mhQs8N35ztWL9Bprljxm430AphBYNxCdOCpsUdCL8iWLQhcuYOLcq6X5ptp6I23AJGgmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by MW3PR11MB4601.namprd11.prod.outlook.com (2603:10b6:303:59::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.17; Thu, 19 Sep
 2024 14:42:42 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::a137:ffd0:97a3:1db4]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::a137:ffd0:97a3:1db4%6]) with mapi id 15.20.7982.018; Thu, 19 Sep 2024
 14:42:42 +0000
Date: Thu, 19 Sep 2024 16:42:36 +0200
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: Reinette Chatre <reinette.chatre@intel.com>
CC: <fenghua.yu@intel.com>, <shuah@kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<ilpo.jarvinen@linux.intel.com>, <tony.luck@intel.com>
Subject: Re: [PATCH v4 2/2] selftests/resctrl: Adjust SNC support messages
Message-ID: <u76ht247rzdgepo4nzuxpnhsen5wndziszus4xag7fze6cdwlu@vbmksm3nzoor>
References: <cover.1720774981.git.maciej.wieczor-retman@intel.com>
 <1fb2703ee27a0dfa13a7aa501b81439c433521ea.1720774981.git.maciej.wieczor-retman@intel.com>
 <2048036f-332b-49d1-a753-3653136d728c@intel.com>
 <zrcau5572lcuahcbntk6bcqh4dcin3jkcjeesvltz7zutriu3c@5v6puvyzayqc>
 <7ccac5b3-cfba-4f31-804b-45da60b0c08f@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7ccac5b3-cfba-4f31-804b-45da60b0c08f@intel.com>
X-ClientProxiedBy: DUZP191CA0005.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4f9::19) To MN0PR11MB6231.namprd11.prod.outlook.com
 (2603:10b6:208:3c4::15)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|MW3PR11MB4601:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b52ebbf-aa79-4496-4c33-08dcd8b950f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?jVuKShIe2hmZG7qnmB6ToMearH5mzHpdprXgrIhv6bDNC7/PKAV8nK43lG?=
 =?iso-8859-1?Q?9hpLqrtniNrbjG+m49i1r59M5Z8sZu8GHk43ni/aAXjIN1LuATC3v61NN/?=
 =?iso-8859-1?Q?5h9HZneUp20+3ppYb+4yhRc+kY44bf+tmGUNSoWN7hu4po+hJ/3Nm7d/bT?=
 =?iso-8859-1?Q?hWDhXWWIKotk6HqgDKHzyGbO1cxzxjMouat9Qp6T//KLIsfhAsl1nJyGxk?=
 =?iso-8859-1?Q?WRR2KBqG5/NxX8iWg87SAtGhNQQrjLQpjM0rlCUuz1P5dQSn8AYDF9xA4I?=
 =?iso-8859-1?Q?3fmYeOe2pcLZ9eh4hSQllfa93LS1SbqSEkCeAVdjLRE3ewxEKt8r5dW31w?=
 =?iso-8859-1?Q?u5aXSAMwbX8SqMtByKavPdJXMQ1jpB52VRCL7Nh8dpp14h0ELmtUKkqGNE?=
 =?iso-8859-1?Q?sGelVBdaaKh9XFwkMfIOvT7s4RJVpOlHoQnInOEhYMr95okVdse3WQ6ASh?=
 =?iso-8859-1?Q?eup3bqd7niKmEMLIJpKfrMVgkNrvZ8jpkIxdWvXUA8jhk5jlYuT5gC1rkl?=
 =?iso-8859-1?Q?25/XDgFoKb8SEwi1vwvZ8KEs5Kd4UpDEoIi7t2VF1V0bF2i3+f+GgHhWOZ?=
 =?iso-8859-1?Q?gfeNe+d38gHy2TJ2/4J8v4kz4FUG/rz+8wxFDRjKblMtlAJxTZzxIFs1fv?=
 =?iso-8859-1?Q?0pGVH1ctR+435pkUs9iccu6ywQC0lTxbrzQUswdsmwJZ2zPx9pjm0o5OUd?=
 =?iso-8859-1?Q?6FBaJ8APt8MQrP6wLHCZmtnzQvqWtkZy4shy8OLs1CcA4cV7g5uPySkZBr?=
 =?iso-8859-1?Q?LOERGP6sTfYTy31Z+jzDOH3THKFstSPMlmS1WKk5XYfWxW05HygZ8M4/Ke?=
 =?iso-8859-1?Q?+M4+LKV2zVWW+UjyYbRbE+7XWA6W3TV/K8etRWUBJQWNYuKkll4FgRmvFA?=
 =?iso-8859-1?Q?uMx/lOlth1taIpUSd1jutb1iwnq2i4xiQd/u9AQnQjRjBFdmjOM4Q7P/gI?=
 =?iso-8859-1?Q?M8ZV34ltmDauxY7a4O9fg0rtWIXtNTtkJ8qJRO5ArxGZmNaVmegIaOIPuu?=
 =?iso-8859-1?Q?CuUbg0tcS81FVnfftR4uArm+wF9YXVVWh7gKhMfGYRRXmzhmwkvbJV4xjA?=
 =?iso-8859-1?Q?0EpMDzqg7RYmDY/MRL7UWvf9fKckW5dFMw+q2JaCczPR4KfzM/G3JWsTLA?=
 =?iso-8859-1?Q?vMI+AWlSc1EG4cvi+fzLiLKIN6sLQ8UigJD13g3ajJg+dvbI1EJ/9RGhBy?=
 =?iso-8859-1?Q?CBD6BAxJqDfo1kgNaRXMb2g37HKmVEnjU3rFvsUsRHz9Z3llF8wowg9uHW?=
 =?iso-8859-1?Q?4kuE04KXo8V+5wJRBGKKQKMTglvRTP9POjwKKSd+fj5rnJLp+ArVsZseDj?=
 =?iso-8859-1?Q?4IZe7tHmkuTrDK5YFMYs+Yxb4MKC1I+2NeGmha3xQxNzftf1eyWF6Xru4e?=
 =?iso-8859-1?Q?O58AVaNFunJnt8LB43BMZih6rTIpUaaA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?dtvrNk8pJ57xuzLhhV74J/HFHwpGqGlW8ribarwKk1ddJzKIVHfbvLrK20?=
 =?iso-8859-1?Q?jpiQXycWxnGN2gDVNJhgEswJuQncD50bxkU9S5Xkg5RNadFCFhD36BBsOT?=
 =?iso-8859-1?Q?cy640jNLmnEP/2p4+hNQ/Dh00tXhh+HbRYxfaTJLahlVYANCgFtMQTyJ//?=
 =?iso-8859-1?Q?ZtY4VM7u68o+xboeDA8fMpmk1pqdGJeCmJX7A6hqTA/XDQxlmOGOu3U1IC?=
 =?iso-8859-1?Q?lbEM/YHGT3OVSeGfWcr86CzSCy19mHs9WlRi3L2aCxI4CYavfRf8K1+leh?=
 =?iso-8859-1?Q?kDn2WxY5bS8a9Dp8Q7NKiLCxS08zjPcKxnknGQ/ut1oETXvxRLoekq50sA?=
 =?iso-8859-1?Q?ZEhrpFp315jwSedl44B7ZPdz/xL7UCy/4gq9AvHhqFV0/y5nq/+/4VLJY1?=
 =?iso-8859-1?Q?+nwpSpqSXKXW6y9UKwEEU6EuVD0hQnIcwRujNVxx9lIF+FwZ5o79K7d/tV?=
 =?iso-8859-1?Q?JfT/Ou+BrLjz1uNCnwvwOijaPxNAUoWnJKxMfrfInutHcpy6zpfMYYKtbg?=
 =?iso-8859-1?Q?VwrkizYVyotPj6pbdZbxWmBHD1fDPkQYndG1cBfgY+kWscsAll7S3WOkKg?=
 =?iso-8859-1?Q?wnN9iAveYGSCOMaEA4UCHLgeYgYpPaKVQF+ueXmqckGa5YPKyBEmIxxWw3?=
 =?iso-8859-1?Q?XmFbiqEPLtGzPlb9mNsQ5uJFnIkVmQqw/czaDGPNOg1G2XhcjJHAJQXy63?=
 =?iso-8859-1?Q?uDYIQu0ReO4j0qygzfJsYZvjhSJ46CSfputmD7HBjoVJIgT7mxFUroEels?=
 =?iso-8859-1?Q?SxdV/6spFIjWnKM2/XIg5VrSd8/rqfQzUtIlikn49stf5pVO7dc0w6WJ0r?=
 =?iso-8859-1?Q?kZF+qVZpdbe7252cFiDjg7dN41IAQy8eMZQ1G5HPi759zwFX3YnQ5vdCRF?=
 =?iso-8859-1?Q?hb7q4GvJb3TYpthNlFSZDNhC/NfwWI3y3dyEBmy7CEScRVYcnKvTAUU3eW?=
 =?iso-8859-1?Q?6unAcOvmffAuz4gmD8bwywrB5ulFbwRD6+SJZEg9UwqNVgxPHQKAFVw97Z?=
 =?iso-8859-1?Q?xAJTQy08NBuFKrpeHzpYFEQYSzLnNs6b9nENSv0y0oyoBOboLS1OCeBZxC?=
 =?iso-8859-1?Q?sVbCHTvCBKPUWUfjZLLKrilcOBxS6nv0xBYLbcmSf0+TzTqRw4DcLqakzM?=
 =?iso-8859-1?Q?v8+1QeyYe7fx/wF52gdI86X6Ai/QQ1STpt3rPFr6yai3HVK6aH4P2mhTfO?=
 =?iso-8859-1?Q?WwPR1QdwtaK+mkKZaQWWU0BCisEV/W2s6NpBKJw3zTMEePJztnymnx9nPa?=
 =?iso-8859-1?Q?2EN8uQwW1A92geyJ0fiEa9bKh9u9uu2mcU52diFIM8OXbvPpXCfY5GNpJO?=
 =?iso-8859-1?Q?faPhLNB6/HdQFEy++0ApRfONL9EmGfEUujH9iD+sI584XqpvZVpoQzVSQh?=
 =?iso-8859-1?Q?YzHPKseT2TWD4xdAfXyhV25eZ5XphQgtw2UwU9zIaAfOjHG7i+M6Qb7Qeb?=
 =?iso-8859-1?Q?m25fEbDK3UYeeqQMyySNyCKq2r84GEvCCZUhOLHSWyO9dnavEVXbVkIMIV?=
 =?iso-8859-1?Q?bGuIRzqYGRTMmx/f7AL7YIOcJE3K0PqdGhYSJaeE6L4aCqdIoJn7gCbcC6?=
 =?iso-8859-1?Q?2vJ5o+bFfunnhISmIbvnnebZYFy5odrNUtsuByDI1RB7g8zKEfFvzKNve4?=
 =?iso-8859-1?Q?xl0UY+8TkEV6bQbMkN/rK42MpEAw/qLsrOGWZWSLN3OwGbNUMwV1ypIBvK?=
 =?iso-8859-1?Q?zFUl4I+dsYjJVwgMpI0=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b52ebbf-aa79-4496-4c33-08dcd8b950f6
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 14:42:42.0506
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2wKX/8s3FfeeU4eSH2juSnB0pWesQMsdy1j7nPXfAeir6hzNunyuuMQLwTpDJ5jbCTq7thwnmTXBBtDVAUAm7kDWGTK/V9bzVnrrRphETjo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4601
X-OriginatorOrg: intel.com

On 2024-09-17 at 08:32:11 -0700, Reinette Chatre wrote:
>Hi Maciej,
>
>On 8/27/24 1:15 AM, Maciej Wieczor-Retman wrote:
>> On 2024-08-12 at 16:40:10 -0700, Reinette Chatre wrote:
>> > On 7/12/24 2:04 AM, Maciej Wieczor-Retman wrote:
>
>> > > +
>> > > +	if ((get_vendor() == ARCH_INTEL) && snc_unreliable) {
>> > > +		ksft_print_msg("Sub-NUMA Clustering could not be detected properly (see earlier messages for details).\n");
>> > > +		ksft_print_msg("Intel CAT may be inaccurate.\n");
>> > > +	}
>> > 
>> > This is still relevant but unclear why previous message checked "ret" but above does not.
>> 
>> The above check tries to explain why a failure happened.
>> 
>> This check is a reminder about a false positive - the test passes but
>> "snc_unreliable" was set. I guess we could make this check to test "!ret"?
>
>Thinking about this more ... if the test results cannot be trusted at all (whether tests pass or
>fail) when snc_reliable is true then it seems more appropriate to just skip these tests when
>SNC detection is unreliable.

Okay, I'll just skip the test if the snc_unreliable is true.


-- 
Kind regards
Maciej Wieczór-Retman

