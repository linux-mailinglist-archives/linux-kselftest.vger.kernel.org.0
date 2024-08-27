Return-Path: <linux-kselftest+bounces-16375-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5F7A960424
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 10:15:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DF2CB22F54
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 08:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9309417BEA4;
	Tue, 27 Aug 2024 08:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UhFig6YM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC691487F4;
	Tue, 27 Aug 2024 08:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724746529; cv=fail; b=ftRWAdKdhIgtd2DMjAa9qNGeq4q4YMEuH++87U/XJQzcaR30WK/nzPBJH/d5wS4MWyU51EKwowSPrtqZ7LFv2/RjNvKxbsRKhVV38JjEdFNAjURf4cQyrOK8Rn3rhC8Y30gDofWCLPEaEaEAz/4iCd1rA+3RYPwDzpsSW1lYvYU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724746529; c=relaxed/simple;
	bh=vPOTuNT1jK/ZwrpSgIWip5SYe+w7iCuESaWzuV3Q6cs=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bKpwC0N3sYkYgt9EefUl2gPMwI42Lv+D+suz8JqoOhrc90cU/dWl1l8RVpQoToff2HTB6JmyyRkVxj6X1hcBIh8xDT7u+c0lxxeCp/uzOO4I0heFKweifHYq5rCOR6zvSADCeQkHiBQj/Snj14nN7C71QotYQOj3lPW95xNcrdU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UhFig6YM; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724746527; x=1756282527;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=vPOTuNT1jK/ZwrpSgIWip5SYe+w7iCuESaWzuV3Q6cs=;
  b=UhFig6YMdlbseMc7hthLD3RvEVkUYazDhI1U2avTmimMim9XZCdltmoo
   hDQmqlMBHh5sieu/hGjD4Pd21wqEfB/YtSa+TUX6R0XJ0WH4Gt8/EUaFo
   yzXPGG6zG64YfUW6Bt3FPYVMC6FdnzBAhkoFxl9qOdQDgvLCq7ys4wDgt
   88j2H863L+lWMsehRfJLhlLd5herlP/YtZfL1eiNyNGGs+009ACe6pUXB
   VMTCibnm7pUYfVi6ydVwbdns+nyOjhEcLqPn1cl2haTvxm0zHiOGQfuux
   L4hHedUTZWbQgQCHr1BGlvy67DXWjguYZMEtygavRPMA8RXsgAQ3ozXdC
   A==;
X-CSE-ConnectionGUID: BuZb/ngpQdGaP4CfiaELgA==
X-CSE-MsgGUID: W718QX4zTee+A2fPDW4lhg==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="23387505"
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="23387505"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 01:15:26 -0700
X-CSE-ConnectionGUID: WmwirweFSYyScjd0mN55xw==
X-CSE-MsgGUID: 0E8TeaP6QIK5Kol5N0aacQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="63303829"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Aug 2024 01:15:25 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 27 Aug 2024 01:15:25 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 27 Aug 2024 01:15:25 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 27 Aug 2024 01:15:24 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.48) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 27 Aug 2024 01:15:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nKFUNNEyqf1AulUihprc0XDX08YuOuSUIOZc6Gh2j3lBJ7ktgYxl8E3uMnb0j43dAJH4cPcYhxpckCc0eDDAoDGq4hn+uVtkLfNYnsWgvLQYS8wlSF3nEbqqW4CtuzjkwXIfUyKqJDyS20iKfPu+UMJ7xRRwdCBHKgJ5J/7EAVkF7LQFCJ3JOpelFuDNaiNmnFXoKo/fczXgmMSygcVgjXumumDaR03RSUfjG0SYEJMZ3QQ1PpocP77FB/5i3IH6qkIWXQiVU67ZGBAOm4tMMFEp0ZkhMbGDpztLbcV8V4B0cOTahjwP5YyO2wWZK3EJTgFGMVmF1KqEk0ivOKl6iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RVLh9egUyInYDKFK8mX4npYnoLxxEbXT3+QQGoV4Ewg=;
 b=Dif2joHdFObIzvxPL1Dnhjq7uKMYku++lAv/LGmBJfsFEcgjz634R13LAdpIeN2TYMiDEZKcTi/khHqYw5R2cxA8h8JxeVNcHrgO0HhQi2iXhZRS9rVbbdubfk91glpxYf67ubmlf3Oz/jqJsYU40pIEv97D+cWQ5iaotWoXkuWci92vC2xBamUOnnBTBwYVu87bO/odUOmAiB0erMkN79MEhVOm+HVAlFz29bTOjWWTytLfrCcCHJdsqTTeC9+fyT10/yJGnu2+WLbYmM8gSul+T2bDgL8F51PMT/PgNy71CSyVW82vlqgFuVLCBPJif4pZYZDG7/KGqKVD9XUjLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by SJ0PR11MB5135.namprd11.prod.outlook.com (2603:10b6:a03:2db::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Tue, 27 Aug
 2024 08:15:22 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::a137:ffd0:97a3:1db4]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::a137:ffd0:97a3:1db4%6]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 08:15:22 +0000
Date: Tue, 27 Aug 2024 10:15:05 +0200
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: Reinette Chatre <reinette.chatre@intel.com>
CC: <fenghua.yu@intel.com>, <shuah@kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<ilpo.jarvinen@linux.intel.com>, <tony.luck@intel.com>
Subject: Re: [PATCH v4 2/2] selftests/resctrl: Adjust SNC support messages
Message-ID: <zrcau5572lcuahcbntk6bcqh4dcin3jkcjeesvltz7zutriu3c@5v6puvyzayqc>
References: <cover.1720774981.git.maciej.wieczor-retman@intel.com>
 <1fb2703ee27a0dfa13a7aa501b81439c433521ea.1720774981.git.maciej.wieczor-retman@intel.com>
 <2048036f-332b-49d1-a753-3653136d728c@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2048036f-332b-49d1-a753-3653136d728c@intel.com>
X-ClientProxiedBy: DUZPR01CA0236.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b5::15) To MN0PR11MB6231.namprd11.prod.outlook.com
 (2603:10b6:208:3c4::15)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|SJ0PR11MB5135:EE_
X-MS-Office365-Filtering-Correlation-Id: 31ea2264-3de2-4a8b-f749-08dcc6706561
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?qX5egnRQRCwXhpc61TNd5Gp2NbjtZLiAV6BJrnITa6KF7Sm2jWC3kAaRuj?=
 =?iso-8859-1?Q?mvtAkgqY01NjxXv2FwUFmEvCQspsoHIuWTfssg7zkC0fXiXmEG5U60KdnS?=
 =?iso-8859-1?Q?Un5zuQkJ+L7s1tg9VU7U3BRJI8f/XAVUVKh90aaCEwyaIO6paqzakzNJka?=
 =?iso-8859-1?Q?4rGOmYdLfJ0DSOFvCTgpcQpSuQy4xbLh9qrrUgF5vjFZsmS//3qpvrLuoP?=
 =?iso-8859-1?Q?MI9b5xClY6TOqpADsOkQD/Nc2mrNu1fDTW46huDgJ23+UKISqGirtOLqcv?=
 =?iso-8859-1?Q?v+EZ3NYCejDvF53nWk+aaJ5KWzFuLH4cZAcpBQhYB+mTJablZgeH6ihiUd?=
 =?iso-8859-1?Q?zasBlA9iw0+vP0B+6/O7lpACGgiE8VtK5TAHZ/ClsX72+6PEw/LflT//Fd?=
 =?iso-8859-1?Q?cjruXEixnw01GKFVoYlZ6JW1GRbciQt6NTPBTyT5l/z+coED9OQuni3KtR?=
 =?iso-8859-1?Q?R0gGv75NpZtrcb5zC1ZX3Bjd2l0MGpo1LExW7Ri+Wx7wIlrqQSBsy0ru63?=
 =?iso-8859-1?Q?xiGa9IqVNAhSjziRernDqg22ZcYYEGdkEWF44AeQuxNpJWHfg6BKgqr/rf?=
 =?iso-8859-1?Q?M7NZQqHTx3G9l3R6Ra78BSLf0EQCY7ffNGKYA5ySrFiYyfEFxc4Bz/mcA1?=
 =?iso-8859-1?Q?HeQgbhIjKLU0lzySluzVNONrDEqIyoJ4RXVrv3ZCuj4WSEpveLpIF3owSr?=
 =?iso-8859-1?Q?iTx/rLsCTEOg9/NMgr6aUzoesPLrelx7FVVeShy0SsGiLni5XxeHzMOH2a?=
 =?iso-8859-1?Q?rw5W/NImFuwBk93xrwNDLdNJr6LbwuxIVjgZZdXavNgRflyxOGjRRgC1mu?=
 =?iso-8859-1?Q?By94Ds1KImkjuFUCfB3j5Z5Ia5Nil7JbLol7fgCfGwwO+2r+hQdfw5NlGN?=
 =?iso-8859-1?Q?Y5V1mk5X+NxA1iZFrDWYcofRZ4+gMPfd7UuJwWNMPygQeFW9WwIt0m/pce?=
 =?iso-8859-1?Q?6Jlk/xfDaiWovRHU6R12SSzsab9rYQHosFYBz3qXd9/HMidh7ALNx1j8JK?=
 =?iso-8859-1?Q?AhdjFHv63QpCZuT3mJ/C7J3WH1aX+xlNtlXeoYxlGCMtd4ALYqdHqy00wa?=
 =?iso-8859-1?Q?5DETZc4mXLTJJIWH+FT8GZRG6GHyPVfG2pgwleP0WCXxCCwnNOoTa6VEB2?=
 =?iso-8859-1?Q?0TgcAzCkFcqorerPZbqHxzWGh8DehOfOu4YlLuFdfY9n4mV0jnXWs3/z+X?=
 =?iso-8859-1?Q?KSSxc/eZCUicYOgAJc1l52JVv0yG4XaskOKibTIkIqSvrqT15EGJnfgI0Z?=
 =?iso-8859-1?Q?SETfNq2zSu5Ry7LyGmTEaTxklK1eLA535u4HlHesUKmQiPLz0aucwqrJV/?=
 =?iso-8859-1?Q?iZLBf2ZeOx75HB112AO1/ts8pXC62nW2vG5UvQHsH47NJrcx3NsVf2moaA?=
 =?iso-8859-1?Q?WvLNwRSGLmLva96gMdubudtGLwSwT8oA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?Z2/6m9Njck8SVcXqWk121I1iH3CYEpwrTxw9Xy/Bssr7voXqkGgbdE0SmX?=
 =?iso-8859-1?Q?hjrGTtctLmxi03Wv92dTNK3OgRxQFDN49PniNdM5zrG/rlJhMgMKuM30Ai?=
 =?iso-8859-1?Q?DbbGnfqx+O/gFwvbkfk7ICeFBnDogJasnf14ybnRWBLsghwmtJqIm6H5si?=
 =?iso-8859-1?Q?VndQTcjeqk3viA7IuDV+jBUlD+HLmuHALOF2NJnpU/C0PsTICW128b6RDR?=
 =?iso-8859-1?Q?1yXsN6ZaK5K1kQhl9GF2Da7MnptarNoieh84EDu4/LKqB7pstzYUCGsaro?=
 =?iso-8859-1?Q?kb4KbdRhgW3WU/3djJe5vHPFzxQhMfz5uLZ6cR0irTTq6zIRXNmcX5jGul?=
 =?iso-8859-1?Q?hWE2XcKC9e9QcVrLqasefKCS9HbxYyYTQxxsf1lxJ+gDO1uB3wqAYO95aj?=
 =?iso-8859-1?Q?uwDuMtlhfTy4QjiXtQgR6HHyS5XPyNZcTtFn33xsbKmiNzXWUm+Fad2XGv?=
 =?iso-8859-1?Q?fqeACJG3BkGTbDJOYK5lA1ptWL1fzNMZwlq0Lnmc6IKwRrT2R8zsy0T/Nb?=
 =?iso-8859-1?Q?amR0KbakD8ymk+ma72wXRL7uHI01Aiubjw+cn4cKNHiW/3wHSBfJKVckYn?=
 =?iso-8859-1?Q?caR551LatgfVAZdTXUzFi/1b7WRFInATiUaW7mH/w67a9D8O6V4EPLa8YK?=
 =?iso-8859-1?Q?UsX0dhWm7GU3ZUhmmmYP16Ei83GbVyovjtQ9Pt6D3yWAkWEVcXbSZBwsfH?=
 =?iso-8859-1?Q?xCFKfLBEmoPK5zfbyE6xrFX6c+SGD1c/X7k9cvTW2ergIKEgpbItIzx3mo?=
 =?iso-8859-1?Q?A8LGQvQUVnNTNXQ9ZEZ3m4MYIINeDTknIvjI93u5y9fX7xKQzJc8CdmmlN?=
 =?iso-8859-1?Q?clZnd86oRUGUPx7azBYXDfgStyJO5m5+oGTRK/ATboRQXlWM27H66tfc9s?=
 =?iso-8859-1?Q?p7kK3EczxzevMGgCPWxOc+A6EoQvYoIu4SzuJpE7A2gkw26G2nKiiJH1F6?=
 =?iso-8859-1?Q?djAC75i+fcq6U3Es+BCAB2m6IPPhAflmLWJB4GLoWyPsPjnxRhyrinbdOs?=
 =?iso-8859-1?Q?+HJVulDFDenkwDaJvOT1q3f0gCfSCB3ZuXXoN2gFYXV1relSnccdN2Zl+h?=
 =?iso-8859-1?Q?EISONBVM6JavZmHqQPowrL72Mt5ULjKybDiTOMJ0NtVo3MOzeCcslg/mAp?=
 =?iso-8859-1?Q?1CG/NGqrGvt1VpPtWWNiC6Y6jkEhpYKvp373n7LmBN/tVzUVxcJ5ifDc5V?=
 =?iso-8859-1?Q?fadrvoPfQ2xkrMgn4NFFXbTW4IYYN+EjW3ycdzpynE6pcrYl/V6G2yCA2Z?=
 =?iso-8859-1?Q?b/jQAHMhXLxG+kaIbAKFNuSQmf9LAHmnOBBqvyiVnOyr+vv+OhUYP28P77?=
 =?iso-8859-1?Q?2EeVUTum8uUgHG1jB3achlmWIRLrj7SFbOOiqCxSu1kHl03aSo6O2HokyY?=
 =?iso-8859-1?Q?Bdg8upAKWaMBMeofx49jxMlQwzacazyoZZEkfynAJqmZZ3IwkXvM/s75lY?=
 =?iso-8859-1?Q?3hlSeGAY17layqMxpKIH2B2BI/1w0lK7lxGZcGgqn7x2xbzFuDj5TATARu?=
 =?iso-8859-1?Q?pbxLwrJ2pAKgLPnyPatI6ERWsw1PptdvzdUXpZca9ldrOrnYqF5Ued48cN?=
 =?iso-8859-1?Q?8FOKXw4WgKv3XuFfiGPex2TEwRb/tJfX2qqfdCwt5hl+u2xW+3heE1u/mO?=
 =?iso-8859-1?Q?bI2OlnU3gz8LuYKfHLLRdBTajWrjDgyMeMGsPHkx4KxAcnOqnzDLTRgZxN?=
 =?iso-8859-1?Q?19f04A+WKE8BqhRLRr4=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 31ea2264-3de2-4a8b-f749-08dcc6706561
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 08:15:22.0897
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cWpiE9Ryf+Sh16TU/o6RtyZobK3YRk4R1MSway6z9o9FhI1uiHf5ZgZu+mNOSM3QvD+PQpOvLiwH9OSiWkxXpRp8qp6oHuKpH8o1XKHgxR0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5135
X-OriginatorOrg: intel.com

On 2024-08-12 at 16:40:10 -0700, Reinette Chatre wrote:
>Hi Maciej,
>
>On 7/12/24 2:04 AM, Maciej Wieczor-Retman wrote:
>> Resctrl selftest prints a message on test failure that Sub-Numa
>> Clustering (SNC) could be enabled and points the user to check their BIOS
>> settings. No actual check is performed before printing that message so
>> it is not very accurate in pinpointing a problem.
>> 
>> Figuring out if SNC is enabled is only one part of the problem, the
>> others being whether the detected SNC mode is reliable and whether the
>> kernel supports SNC in resctrl.
>> 
>> When there is SNC support for kernel's resctrl subsystem and SNC is
>> enabled then sub node files are created for each node in the resctrlfs.
>> The sub node files exist in each regular node's L3 monitoring directory.
>> The reliable path to check for existence of sub node files is
>> /sys/fs/resctrl/mon_data/mon_L3_00/mon_sub_L3_00.
>> 
>> To check if SNC detection is reliable one can check the
>> /sys/devices/system/cpu/offline file. If it's empty, it means all cores
>> are operational and the ratio should be calculated correctly. If it has
>> any contents, it means the detected SNC mode can't be trusted and should
>> be disabled.
>> 
>
>This belongs in previous patch.

Sure, will change it.

>
>> Add helpers for all operations mentioned above.
>> 
>> Detect SNC mode once and let other tests inherit that information.
>
>This belongs to previous patch.

Okay, I can add that too.

>
>> 
>> Add messages to alert the user when SNC detection could return incorrect
>> results. Correct old messages to account for kernel support of SNC in
>> resctrl.
>> 
>> Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
>> ---
>> Changelog v4:
>> - Change messages at the end of tests and at the start of
>>    run_single_test. (Reinette)
>> - Add messages at the end of CAT since it can also fail due to enabled
>>    SNC + lack of kernel support.
>> - Remove snc_mode global variable. (Reinette)
>> - Fix wrong description of snc_kernel_support(). (Reinette)
>> - Move call to cpus_offline_empty() into snc_nodes_per_l3_cache() so the
>>    whole detection flow is in one place as discussed. (Reinette)
>> 
>> Changelog v3:
>> - Change snc_ways() to snc_nodes_per_l3_cache(). (Reinette)
>> - Add printing the discovered SNC mode. (Reinette)
>> - Change method of kernel support discovery from cache sizes to
>>    existance of sub node files.
>> - Check if SNC detection is unreliable.
>> - Move SNC detection to only the first run_single_test() instead on
>>    error at the end of test runs.
>> - Add global value to remind user at the end of relevant tests if SNC
>>    detection was found to be unreliable.
>> - Redo the patch message after the changes.
>> 
>> Changelog v2:
>> - Move snc_ways() checks from individual tests into
>>    snc_kernel_support().
>> - Write better comment for snc_kernel_support().
>> 
>>   tools/testing/selftests/resctrl/cat_test.c    |  8 +++
>>   tools/testing/selftests/resctrl/cmt_test.c    | 10 +++-
>>   tools/testing/selftests/resctrl/mba_test.c    |  7 +++
>>   tools/testing/selftests/resctrl/mbm_test.c    |  9 ++-
>>   tools/testing/selftests/resctrl/resctrl.h     |  3 +
>>   .../testing/selftests/resctrl/resctrl_tests.c |  8 ++-
>>   tools/testing/selftests/resctrl/resctrlfs.c   | 57 +++++++++++++++++++
>>   7 files changed, 97 insertions(+), 5 deletions(-)
>> 
>> diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
>> index d4dffc934bc3..a8bb49f56755 100644
>> --- a/tools/testing/selftests/resctrl/cat_test.c
>> +++ b/tools/testing/selftests/resctrl/cat_test.c
>> @@ -285,6 +285,14 @@ static int cat_run_test(const struct resctrl_test *test, const struct user_param
>>   	ret = check_results(&param, test->resource,
>>   			    cache_total_size, full_cache_mask, start_mask);
>> +	if (ret && (get_vendor() == ARCH_INTEL) && !snc_kernel_support())
>> +		ksft_print_msg("Kernel doesn't support Sub-NUMA Clustering but it is enabled on the system.\n");
>
>The kernel support only applies to monitoring, there is no kernel support/changes related to CAT when SNC
>is enabled.

I rechecked the CAT test and it seems to indeed be fine. I recall it failed a
while ago when there was no kernel support but I guess now it is fixed.

I'll drop the above check.

>
>> +
>> +	if ((get_vendor() == ARCH_INTEL) && snc_unreliable) {
>> +		ksft_print_msg("Sub-NUMA Clustering could not be detected properly (see earlier messages for details).\n");
>> +		ksft_print_msg("Intel CAT may be inaccurate.\n");
>> +	}
>
>This is still relevant but unclear why previous message checked "ret" but above does not.

The above check tries to explain why a failure happened.

This check is a reminder about a false positive - the test passes but
"snc_unreliable" was set. I guess we could make this check to test "!ret"?

>
>> +
>>   	return ret;
>>   }
>> diff --git a/tools/testing/selftests/resctrl/cmt_test.c b/tools/testing/selftests/resctrl/cmt_test.c
>> index 0c045080d808..471e134face0 100644
>> --- a/tools/testing/selftests/resctrl/cmt_test.c
>> +++ b/tools/testing/selftests/resctrl/cmt_test.c
>> @@ -175,8 +175,14 @@ static int cmt_run_test(const struct resctrl_test *test, const struct user_param
>>   		goto out;
>>   	ret = check_results(&param, span, n);
>> -	if (ret && (get_vendor() == ARCH_INTEL))
>> -		ksft_print_msg("Intel CMT may be inaccurate when Sub-NUMA Clustering is enabled. Check BIOS configuration.\n");
>> +	if (ret && (get_vendor() == ARCH_INTEL) && !snc_kernel_support())
>> +		ksft_print_msg("Kernel doesn't support Sub-NUMA Clustering but it is enabled on the system.\n");
>> +
>> +	if ((get_vendor() == ARCH_INTEL) && snc_unreliable) {
>> +		ksft_print_msg("Sub-NUMA Clustering could not be detected properly (see earlier messages for details).\n");
>> +		ksft_print_msg("Intel CMT may be inaccurate.\n");
>> +	}
>> +
>
>CMT may be inaccurate in both scenarios (no kernel support or unreliable detection). Why only
>check "ret" in case there is no kernel support?

I guess the same thing from above can apply here? Test "!ret"? Perhaps then make
this check into "else if ()" instead of just "if" since they will be exclusive?

>
>>   out:
>>   	free(span_str);
>> diff --git a/tools/testing/selftests/resctrl/mba_test.c b/tools/testing/selftests/resctrl/mba_test.c
>> index ab8496a4925b..a805c14fe04b 100644
>> --- a/tools/testing/selftests/resctrl/mba_test.c
>> +++ b/tools/testing/selftests/resctrl/mba_test.c
>> @@ -179,6 +179,13 @@ static int mba_run_test(const struct resctrl_test *test, const struct user_param
>>   		return ret;
>>   	ret = check_results();
>> +	if (ret && (get_vendor() == ARCH_INTEL) && !snc_kernel_support())
>> +		ksft_print_msg("Kernel doesn't support Sub-NUMA Clustering but it is enabled on the system.\n");
>> +
>> +	if ((get_vendor() == ARCH_INTEL) && snc_unreliable) {
>> +		ksft_print_msg("Sub-NUMA Clustering could not be detected properly (see earlier messages for details).\n");
>> +		ksft_print_msg("Intel MBA may be inaccurate.\n");
>> +	}
>
>As I understand there is no change to MBA when SNC is enabled. These additions thus seem unnecessary.

I just rechecked by installing 6.9 kernel (no SNC kernel support) and using this
series selftest. MBA seems to fail in these conditions. I think it is because
MBA pulls values from resctrl and from iMC and then compares them. My guess is
that iMC works on the halved cache while resctrl (without new SNC support) uses
the whole cache. Here is the log from the MBA test I did:

TAP version 13
# Pass: Check kernel supports resctrl filesystem
# Pass: Check resctrl mountpoint "/sys/fs/resctrl" exists
# resctrl filesystem not mounted
# dmesg: [   11.574208] resctrl: L3 allocation detected
# dmesg: [   11.578421] resctrl: MB allocation detected
# dmesg: [   11.582615] resctrl: L3 monitoring detected
1..1
# SNC-2 mode discovered.
# Starting MBA test ...
# Mounting resctrl to "/sys/fs/resctrl"
# Benchmark PID: 2764
# Writing benchmark parameters to resctrl FS
# Write schema "MB:0=100" to resctrl FS
...
# Write schema "MB:0=10" to resctrl FS
# Results are displayed in (MB)
# Fail: Check MBA diff within 8% for schemata 100
# avg_diff_per: 102%
# avg_bw_imc: 14221
# avg_bw_resc: 28804
# Fail: Check MBA diff within 8% for schemata 90
# avg_diff_per: 102%
# avg_bw_imc: 14146
# avg_bw_resc: 28648
...
# Fail: Check MBA diff within 8% for schemata 20
# avg_diff_per: 93%
# avg_bw_imc: 3712
# avg_bw_resc: 7178
# Fail: Check MBA diff within 8% for schemata 10
# avg_diff_per: 92%
# avg_bw_imc: 728
# avg_bw_resc: 1405
# Fail: Check schemata change using MBA
# At least one test failed
# Kernel doesn't support Sub-NUMA Clustering but it is enabled on the system.
not ok 1 MBA: test
# Totals: pass:0 fail:1 xfail:0 xpass:0 skip:0 error:0

>
>>   	return ret;
>>   }
>> diff --git a/tools/testing/selftests/resctrl/mbm_test.c b/tools/testing/selftests/resctrl/mbm_test.c
>> index 6b5a3b52d861..ce3c86989f8b 100644
>> --- a/tools/testing/selftests/resctrl/mbm_test.c
>> +++ b/tools/testing/selftests/resctrl/mbm_test.c
>> @@ -147,8 +147,13 @@ static int mbm_run_test(const struct resctrl_test *test, const struct user_param
>>   		return ret;
>>   	ret = check_results(DEFAULT_SPAN);
>> -	if (ret && (get_vendor() == ARCH_INTEL))
>> -		ksft_print_msg("Intel MBM may be inaccurate when Sub-NUMA Clustering is enabled. Check BIOS configuration.\n");
>> +	if (ret && (get_vendor() == ARCH_INTEL) && !snc_kernel_support())
>> +		ksft_print_msg("Kernel doesn't support Sub-NUMA Clustering but it is enabled on the system.\n");
>> +
>> +	if ((get_vendor() == ARCH_INTEL) && snc_unreliable) {
>> +		ksft_print_msg("Sub-NUMA Clustering could not be detected properly (see earlier messages for details).\n");
>> +		ksft_print_msg("Intel MBM may be inaccurate.\n");
>> +	}
>>   	return ret;
>>   }
>> diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
>> index 851b37c9c38a..488bdca01e4f 100644
>> --- a/tools/testing/selftests/resctrl/resctrl.h
>> +++ b/tools/testing/selftests/resctrl/resctrl.h
>> @@ -121,6 +121,8 @@ struct perf_event_read {
>>    */
>>   extern volatile int *value_sink;
>> +extern int snc_unreliable;
>> +
>>   extern char llc_occup_path[1024];
>>   int snc_nodes_per_l3_cache(void);
>> @@ -167,6 +169,7 @@ void ctrlc_handler(int signum, siginfo_t *info, void *ptr);
>>   int signal_handler_register(const struct resctrl_test *test);
>>   void signal_handler_unregister(void);
>>   unsigned int count_bits(unsigned long n);
>> +int snc_kernel_support(void);
>>   void perf_event_attr_initialize(struct perf_event_attr *pea, __u64 config);
>>   void perf_event_initialize_read_format(struct perf_event_read *pe_read);
>> diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
>> index ecbb7605a981..4b84d6199a36 100644
>> --- a/tools/testing/selftests/resctrl/resctrl_tests.c
>> +++ b/tools/testing/selftests/resctrl/resctrl_tests.c
>> @@ -118,11 +118,17 @@ static bool test_vendor_specific_check(const struct resctrl_test *test)
>>   static void run_single_test(const struct resctrl_test *test, const struct user_params *uparams)
>>   {
>> -	int ret;
>> +	int ret, snc_mode;
>>   	if (test->disabled)
>>   		return;
>> +	snc_mode = snc_nodes_per_l3_cache();
>> +	if (snc_mode > 1)
>> +		ksft_print_msg("SNC-%d mode discovered.\n", snc_mode);
>> +	else if (snc_unreliable)
>> +		ksft_print_msg("SNC detection unreliable due to offline CPUs. Test results may not be accurate if SNC enabled.\n");
>> +
>>   	if (!test_vendor_specific_check(test)) {
>>   		ksft_test_result_skip("Hardware does not support %s\n", test->name);
>>   		return;
>> diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
>> index 803dd415984c..4d0dbb332b8f 100644
>> --- a/tools/testing/selftests/resctrl/resctrlfs.c
>> +++ b/tools/testing/selftests/resctrl/resctrlfs.c
>> @@ -13,6 +13,8 @@
>>   #include "resctrl.h"
>> +int snc_unreliable;
>> +
>>   static int find_resctrl_mount(char *buffer)
>>   {
>>   	FILE *mounts;
>> @@ -186,6 +188,25 @@ static unsigned int count_sys_bitmap_bits(char *name)
>>   	return count;
>>   }
>> +static bool cpus_offline_empty(void)
>> +{
>> +	char offline_cpus_str[64];
>> +	FILE *fp;
>> +
>> +	fp = fopen("/sys/devices/system/cpu/offline", "r");
>> +	if (fscanf(fp, "%s", offline_cpus_str) < 0) {
>> +		if (!errno) {
>> +			fclose(fp);
>> +			return 1;
>> +		}
>> +		ksft_perror("Could not read offline CPUs file!");
>
>No need to scream.

Sure, I guess I missed this when removing exclamation marks last time.

>
>I think it will be more useful to replace "offline CPUs file" with
>specific "/sys/devices/system/cpu/offline".

Sure, will change.

>
>> +	}
>> +
>> +	fclose(fp);
>> +
>> +	return 0;
>> +}
>> +
>>   /*
>>    * Detect SNC by comparing #CPUs in node0 with #CPUs sharing LLC with CPU0.
>>    * If some CPUs are offline the numbers may not be exact multiples of each
>> @@ -199,6 +220,13 @@ int snc_nodes_per_l3_cache(void)
>>   	static int snc_mode;
>>   	if (!snc_mode) {
>> +		if (!cpus_offline_empty()) {
>> +			ksft_print_msg("Runtime SNC detection unreliable due to offline CPUs.\n");
>> +			ksft_print_msg("Setting SNC mode to disabled.\n");
>> +			snc_mode = 1;
>> +			snc_unreliable = 1;
>> +			return snc_mode;
>> +		}
>
>This can be moved to previous patch and that for loop simplified/removed.

Okay.

>
>>   		node_cpus = count_sys_bitmap_bits("/sys/devices/system/node/node0/cpumap");
>>   		cache_cpus = count_sys_bitmap_bits("/sys/devices/system/cpu/cpu0/cache/index3/shared_cpu_map");
>> @@ -942,3 +970,32 @@ unsigned int count_bits(unsigned long n)
>>   	return count;
>>   }
>> +
>> +/**
>> + * snc_kernel_support - Check for existence of mon_sub_L3_00 file that indicates
>> + * SNC resctrl support on the kernel side.
>> + *
>> + * Return: 0 if not supported, 1 if SNC is disabled or SNC is both enabled and
>> + * supported.
>> + */
>> +int snc_kernel_support(void)
>> +{
>> +	char node_path[PATH_MAX];
>> +	struct stat statbuf;
>> +	int ret;
>> +
>> +	ret = snc_nodes_per_l3_cache();
>> +	/*
>> +	 * If SNC is disabled then its kernel support isn't important.
>
>Please expand comment that this does not take unreliable SNC detection into account and
>needs to be done separately.

Okay, I also just noticed that the return value in the function comment also needs
an update.

>
>> +	 */
>> +	if (ret == 1)
>> +		return ret;
>> +
>> +	snprintf(node_path, sizeof(node_path), "%s/%s/%s", RESCTRL_PATH, "mon_data",
>> +		 "mon_L3_00/mon_sub_L3_00");
>> +
>> +	if (!stat(node_path, &statbuf))
>> +		return 1;
>> +
>> +	return 0;
>> +}
>
>Reinette

-- 
Kind regards
Maciej Wieczór-Retman

