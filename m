Return-Path: <linux-kselftest+bounces-15619-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C46659563CC
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 08:36:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB9DA1C212A7
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 06:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60F90150996;
	Mon, 19 Aug 2024 06:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OxzXKkl1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDF013D243;
	Mon, 19 Aug 2024 06:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724049368; cv=fail; b=tn4dJQ7jetQZhdLp6eN5JxZEv4nPA8y0s4I2sM8KOuP9pcLx1u9vfnm9NlY8RQMLvfv13FZuv8TgXLgjgqmdrxTxDd9BesC9g2Bc1Fxh9i/aAmGC7WOJMGvankwt6jToSRDG8lKTII+ResYn6ZP8hA+U6oI24OdMSUmbI0H6Nz4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724049368; c=relaxed/simple;
	bh=7n664Zh85mousTmTdEotSr1iHM3zM3W5KXu62bvHbAA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fnTSJ1qCvrW4lGWTTzdcluIcKXgl09igaMne0+1gWHeRhnPxu16a6WQOAkPdHTTDEkLn0OIuaL6B3UFoCI6TnbNmlyaFxmq/Wknr83hAEJnRBPn/YqYyz8QA55yYDrntBezeJS65nUZY2wKGwku6nQtpT69yex71OpV6nALLulg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OxzXKkl1; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724049362; x=1755585362;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=7n664Zh85mousTmTdEotSr1iHM3zM3W5KXu62bvHbAA=;
  b=OxzXKkl106jF1T5Kok8Rm2eAWtVgInCws4aA0TMcN/JIjtkBDCoPjZq6
   T6n1p0IF+83SNCoM/3X+mYSSZZM1LISKm/cpQE7Uiy6mWAebDaDauCdQa
   e59eNs3jSe5JCRYY/bUgoXj5U9oXbuBP602w7TkweQXg7jKlk+XKMz63u
   m7NhwnNdESVt457boPJaRB/PGweRQKmB2PpW0dIpL8Wi14DC4dIzC7z0h
   K87v92lj+IQY4EtMCHb3OXpq8vyE5T17eFeRvOaKs3kWhu+VoR3GjCYmi
   p12ULAtGgzhyC0fZTT61loKf0IYwg4ZsTdQiZjRXIKwxdCzs4Qx0CrEZ6
   Q==;
X-CSE-ConnectionGUID: vFOkw4QdRC+Zi7cD9heirQ==
X-CSE-MsgGUID: +5I5w4B5SIqbhBtIrs9tLg==
X-IronPort-AV: E=McAfee;i="6700,10204,11168"; a="22449918"
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="22449918"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2024 23:36:01 -0700
X-CSE-ConnectionGUID: 7xRKApI2QJmJ5W/10OB6SA==
X-CSE-MsgGUID: mI8259UMRKyW5HEVREUonw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="64931744"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Aug 2024 23:36:00 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 18 Aug 2024 23:35:59 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 18 Aug 2024 23:35:58 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 18 Aug 2024 23:35:58 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 18 Aug 2024 23:35:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZlNiORpvkkYAfNN1gpactRfWSYxozQ3fp8gQIC54Dx1jLJ/Zb8qr4vIkOoqzNd7qsZndEOOhEEaJB4VDdpH3sO7AGVO9HSu8qgHtrWtPJcegQ/AtDvxLsL6YEr3x8wJ4JJ0nmW/jxtIGjKVpjzLtenqEE5ZiAFaWGYkWzvi0BSOhy09AZXsAXFYq/fx50yS/qgR5IxIGPeXa2kGL17aHZoCJjCusFUUm/vXXM935iy4+Q2VPhy6qW+ZwJTX6tdyweWUMBPP3gE3yMhsKClZ+Rxx+PoyQinrf3XO0vzD2BodFkxaWh801SD58v/RJfn3l2FJ1BDXSgrExY27+pZtfVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OqllFodWsaWx45J/yAutymvHAwmfW6nPsSX8t34O3R4=;
 b=adqSduQXw77ydaIIPa5e+mLo0TfqMnoo5BnUDX6g4yFk4Tu6jeEhr+rv+KB51Tl1CWsWl53YQMypfoAFbbAgeFziESta3oWubZ0aabn6Wyu+zNwbXim+t38Buj0A1hZgFfbpijJhPIUxMXYFdi0y+GEBOcxGOzNoLLkU9mXRqFCk7OFDFLJ7dZxNAK4q6aR2ggliP8Z7VHggmixSfuAzD0tR61i4jMT+b0Ma49pxwn+viUCFgRkS0OQP+7BOje32CDFrerujCewQMxNk8zO6tFKemy96bG5G3M1wFlKWlobjlQkChXikYRt416rgOmcVlZvtHPQa3ppZJM5JnvTr5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by LV2PR11MB6048.namprd11.prod.outlook.com (2603:10b6:408:178::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 06:35:51 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 06:35:51 +0000
Date: Mon, 19 Aug 2024 14:35:40 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Jeff Xu <jeffxu@google.com>
CC: Jeff Xu <jeffxu@chromium.org>, <akpm@linux-foundation.org>,
	<willy@infradead.org>, <torvalds@linux-foundation.org>,
	<Liam.Howlett@oracle.com>, <pedro.falcato@gmail.com>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-hardening@vger.kernel.org>,
	<lorenzo.stoakes@oracle.com>, <mpe@ellerman.id.au>, <vbabka@suse.cz>,
	<keescook@chromium.org>, <oliver.sang@intel.com>
Subject: Re: [PATCH v1 0/2] mremap refactor: check src address for vma
 boundaries first.
Message-ID: <ZsLnvO2lWwCZsD6V@xsang-OptiPlex-9020>
References: <20240814071424.2655666-1-jeffxu@chromium.org>
 <CABi2SkX+3JrDk6b59vgvjb8XAkC7_p3-cSkFHOotra1Yh6dv1Q@mail.gmail.com>
 <CABi2SkXtZLojx3AQU4C=41NtBPGjVB2+fv_KWziOqyXRQ8P7Bg@mail.gmail.com>
 <Zr670gX13gKJOtG9@xsang-OptiPlex-9020>
 <CALmYWFvEaYZHBDy74V4gmEExTuMpYg3G+qGUvjL5WtpSVrVqRg@mail.gmail.com>
 <ZsG+yfTDCQSd1Lh7@xsang-OptiPlex-9020>
 <ZsKiC+MSWbAOxxDA@xsang-OptiPlex-9020>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZsKiC+MSWbAOxxDA@xsang-OptiPlex-9020>
X-ClientProxiedBy: SI1PR02CA0004.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::12) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|LV2PR11MB6048:EE_
X-MS-Office365-Filtering-Correlation-Id: d064d05b-2cd3-4952-e292-08dcc0192b28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?PFg9uDlzkl8RNXqrZOW0qa38ScSVShcqbXvrh7eG09S1GBA/VgUpboEhr5?=
 =?iso-8859-1?Q?6PqXUclDQXW1dxOGQj44E83w35D6vowwzr1Z0MTHKgwtxqdwX/SCsYq8r2?=
 =?iso-8859-1?Q?uHlNoWJTAVJfoYtwFJ/wLcUs/QmXZEDnzxN+iVIiP1Ae2jMIDjSV1UbDtK?=
 =?iso-8859-1?Q?wYirASPS1JtQTrWMgg3BLXSxN3oLnSPo2p84gworX0Hz/hQrPEIZiobTQm?=
 =?iso-8859-1?Q?Z0H1zmqvNrYatChseyaKsZAJBaXYR2bTQC5T8zc35qwl72Q16KSGqtR/fo?=
 =?iso-8859-1?Q?YdUTjAM7IIDs2CwBRfLu66E8fhZR5bUxQ1rimJovUzn4/+p/GWmjHhWanO?=
 =?iso-8859-1?Q?x9t3D/Zvlx++LYmCPuUTd91x37esUjBNm0sgcCHmRZKc7l9ikJG5xyuL29?=
 =?iso-8859-1?Q?KFm2nIwaGooslb9vNKJVipu9F+u9eu0I0DQAqrAX5NRfEktVLAYejBekno?=
 =?iso-8859-1?Q?cQR6SCKD7PDOyWMAAW6MKuH401aMWQwx0wR6UpeoDc7EpPNWTWoTI0rr7f?=
 =?iso-8859-1?Q?E6eQ/nRwd7eo1SMoowzGmTsHx9khsOTrQHo31fyKstbDM9k4MAKUdPTWQr?=
 =?iso-8859-1?Q?/ULxxPzpsWxBgPBiafkbebMU8AlkM2oUtIsyMp7wv4LsWIvKzJjzv1nrVQ?=
 =?iso-8859-1?Q?emD+DnrPkQd8N2fvrdDNM7lIFRkPXByZQX1RDurs9oo+JG5oFtNAD9UkZe?=
 =?iso-8859-1?Q?Cb1L6ML8dyCePr4v3fLcXs9EOA6OxjWRLFPl9Ojt2OBmSkZhCPBjdq6F2I?=
 =?iso-8859-1?Q?JVs85JeubgwdElg9xf8p7QEBfx9X8brO+qyCIlS2sdN56LnPefzWwZMX08?=
 =?iso-8859-1?Q?JpjUu3UgleDk8uRD/ZfUgkbEDBBAp4vz9cKMew3MjqkujtKaF0IH7ILrPJ?=
 =?iso-8859-1?Q?ULUvz5v64o6yvkqzmkedw3fKR2dAibNQxh1Riygs8M+qVGoO86w3sJpaWb?=
 =?iso-8859-1?Q?Ok1nVCXKH9fjLK+eQxKPTf63si7zUyMH4Yhw7Z8PTuvYmRqWIg1wQOrUSl?=
 =?iso-8859-1?Q?wiFuXz4oBLvWwl4/DD+vyjKuT7yF9Tb6g3Pi4RnjUaE27GpZv6r9DKgxmE?=
 =?iso-8859-1?Q?LeQFcnOwcgcYPycpXBgBE1dnnskWH0jxIlozHzr5Fo4EZcxrA8OXGtyZii?=
 =?iso-8859-1?Q?ZzG/jcj1gTkPcpgVHR+Nrp3mrrnxjpF9bgQ9XOTyTtJblfR8rvui8Spd0f?=
 =?iso-8859-1?Q?/aPqEJb3aQoeAckEXCZb32LBswCg8GMdbmdj+Ma0dIZXQbCiaY/IbS8y3D?=
 =?iso-8859-1?Q?4k1MYcK93rVvPirGwxo4bfRiRfD8UIZIDF9LaAPKDWrVvZ8D82Bw3ByFLp?=
 =?iso-8859-1?Q?Ry2nht/NhbK/EV9lug586zf8fNSrCCtaAYk3KeR+d3EnfO/K/G8EBoxLFS?=
 =?iso-8859-1?Q?XTzuu5q56k?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?JI51ZQ8zF0CNoUh3AxjqIX8XritSNq9veWnVHijgEmJ7MpHeJTt48Giz89?=
 =?iso-8859-1?Q?jU5Gyd8QL2PkGEZ1pzk9XY1z/WSuYYbkhgAVgmOQISBWOQKiYqB5othBAe?=
 =?iso-8859-1?Q?jbR8EAxesMO8fOYk+Zb96IlH/O8hCFoCKK2pkN4HQHIRdPc+EAggbov63M?=
 =?iso-8859-1?Q?8qt7KC8WZQ27XBgBsvxIp/4cpWwdVsGoSWoUpIjyJOZww2Vx9qqDsNe1hz?=
 =?iso-8859-1?Q?+CC+z5l3FX04OfV6ysyawk/jCK1cUK3ujUuXMkjQeIVsHO9iC+n/mOrU2l?=
 =?iso-8859-1?Q?/X3g0lP4TI2BGDNU1owWJ68NBzCNjLR/loHLcMuvtJ0jgQnC5b70H7FrBC?=
 =?iso-8859-1?Q?uEqWJUrLOYOVXFL7fKDA9jF3CQ7FmiYbBEeCNvTyFTIZLiKHlGI+PqH/D0?=
 =?iso-8859-1?Q?IZu7ODh6MdpvbWgSu9PVG6+o8FDpHIgh1E+d5qXBjjtzlQ3Y+khdBobQjg?=
 =?iso-8859-1?Q?H2LEhHcRTsvzIUPO0dpkVU7NXORS6/eQLQRR3VRb58ytRMAhfAM4NawoUP?=
 =?iso-8859-1?Q?blpJijUfN07J9PHFMXCF8DIe9aJLNGSG7lForJgPtYg8Vx0fHhjZtphVAZ?=
 =?iso-8859-1?Q?4ieSUwSDrA7zUoeZQWbKHyFQR75PaEgj8R6P8+cW9Or8sSrOcZOhPw3Gsa?=
 =?iso-8859-1?Q?0wspms141NRGKu5ge1CVwZyX96lAXpAD+jw7WcGz2hSVgkqYCgSPMtWTt/?=
 =?iso-8859-1?Q?3Rb/BbAYpdjdnvUr7tdzopVwsz8jDtC4gXxNq5Ice3N4L1wHNtLbixAG/9?=
 =?iso-8859-1?Q?TYMSrGjIxGuht9GfI41HFr7HG3jn44w+7vN5f0TC7M/tnIZgE/8XLxOfRO?=
 =?iso-8859-1?Q?q0NOGx6lb7K8eABWgSPzUhA5c2AyL/v3pShed2xbZ/ApuuDTfAtbnI7DIl?=
 =?iso-8859-1?Q?OUfkoH9if+u3uGvznMa0SsI1G0rMXfqTmjLozNzzX3OgukMprSmoBdmG6p?=
 =?iso-8859-1?Q?XfVNAW47vaBKqg4/u03texSnqb6oq2F4UXmxiaz9kByMhizMBJgF1cX7Q4?=
 =?iso-8859-1?Q?ZSOT30OYRMUmNtS3Ccl2nCDyn/sbmsBymZtenwXtg6MjkI+Lxub2JBwo4/?=
 =?iso-8859-1?Q?fV9t778vajCvfJqvYg+qRfAK2Auu7Q7azyD1JRxXa/ia5fmFEfo2yRqhJX?=
 =?iso-8859-1?Q?Qf2NSAvEEbL1nOcGI3Xyfihzjy7yLrCAAPmliKp6lPqC2basaemNqi6reY?=
 =?iso-8859-1?Q?RImkgoDWBvutjMy5B4X/R2eo7u6ug3z3c9R1X2nlI3rRFTK6PNq7BXlU+p?=
 =?iso-8859-1?Q?2T2PaBzai4DwkeGrmoIW1ieY+Hc7mkwqiEKkfjS+65TkttsbJN6Fzm5p6s?=
 =?iso-8859-1?Q?E9aXLEQuJWhjttIkuKXTb07eySqIk3EbrSj/XFM6YCFexWIUypBREYAQ6n?=
 =?iso-8859-1?Q?zRafUPw6SbRt7MA0ucWsVM5vFIQ5M29KkJgtXnyg0HKkJR1JiqyiBjuqpH?=
 =?iso-8859-1?Q?klWeJN7u58GglQIPD6selSf7wC2q+La38NOb8r5mKqyzNxBEbHeq+eXwW6?=
 =?iso-8859-1?Q?R1mkDbgUAAtb1LbvE2fRR2ub24+h4W4P99nnidXUhWaofG6gtRqIGZK2j6?=
 =?iso-8859-1?Q?Ded2iqwjgDS/kiDhjZRorSgIu90WilBs+gIVCu7EQXZjrYSSMl9QhSxIdD?=
 =?iso-8859-1?Q?HdJ4k6aZo3xmjQVDWmEMUia3osn1lQE/YcpazGEa45KB92kdl1zDiXtg?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d064d05b-2cd3-4952-e292-08dcc0192b28
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 06:35:51.4679
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /91Pj30Enx0TXViM7tUa3WTdRgF/TZutbpsqaHbNgHmpWAc1oACUJRcGFj6ZG8NN8QAixC5UOmVQoB9cA6BHEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB6048
X-OriginatorOrg: intel.com

hi, Jeff,

On Mon, Aug 19, 2024 at 09:38:19AM +0800, Oliver Sang wrote:
> hi, Jeff,
> 
> On Sun, Aug 18, 2024 at 05:28:41PM +0800, Oliver Sang wrote:
> > hi, Jeff,
> > 
> > On Thu, Aug 15, 2024 at 07:58:57PM -0700, Jeff Xu wrote:
> > > Hi Oliver
> > 
> > [...]
> > 
> > > > could you exlictly point to two commit-id?
> > > sure
> > > 
> > > this patch
> > > 8be7258a: mseal: add mseal syscall
> > > ff388fe5c: mseal: wire up mseal syscall
> > 
> > I failed to apply this patch set to "8be7258a: mseal: add mseal syscall"
> 
> look your patch set again
> [PATCH v1 1/2] mseal:selftest mremap across VMA boundaries
> just for kselftests
> 
> and I can apply
> [PATCH v1 2/2] mseal: refactor mremap to remove can_modify_mm
> upon "8be7258a: mseal: add mseal syscall" cleanly
> 
> so I will start test for this [PATCH v1 2/2]
> 
> BTW, I will firstly use our default setting - "60s testtime; reboot between each
> run; run 10 times", since we've already have the data for 8be7258a and ff388fe5c
> then we could give you an update kind of quickly.
> 
> as some private mail discussed, you want some special run method, could you
> elaborate them here? thanks

here is a quick update before you give us more details about special run method.

by our default run method (60s testtime; reboot between each run; run 10 times),
your "[PATCH v1 2/2] mseal: refactor mremap to remove can_modify_mm" could
resolve regression partically.

=========================================================================================
compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-12/performance/x86_64-rhel-8.3/100%/debian-12-x86_64-20240206.cgz/lkp-icl-2sp7/pagemove/stress-ng/60s

commit:
  ff388fe5c4 ("mseal: wire up mseal syscall")
  8be7258aad ("mseal: add mseal syscall")
  2a78ece39f  <-- your "[PATCH v1 2/2] mseal: refactor mremap to remove can_modify_mm"

ff388fe5c481d39c 8be7258aad44b5e25977a98db13 2a78ece39f13ea6f3f9679a6c66
---------------- --------------------------- ---------------------------
         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \
      4957            +1.3%       5023            +1.0%       5008        time.percent_of_cpu_this_job_got
      2915            +1.5%       2959            +1.2%       2949        time.system_time
     65.96            -7.3%      61.16            -5.5%      62.30        time.user_time
  41535878            -4.0%   39873501            -2.6%   40452264        proc-vmstat.numa_hit
  41466104            -4.0%   39806121            -2.6%   40384854        proc-vmstat.numa_local
  77297398            -4.1%   74165258            -2.6%   75286134        proc-vmstat.pgalloc_normal
  77016866            -4.1%   73886027            -2.6%   75012630        proc-vmstat.pgfree
  18386219            -5.0%   17474214            -2.9%   17850959        stress-ng.pagemove.ops
    306421            -5.0%     291207            -2.9%     297490        stress-ng.pagemove.ops_per_sec
      4957            +1.3%       5023            +1.0%       5008        stress-ng.time.percent_of_cpu_this_job_got
      2915            +1.5%       2959            +1.2%       2949        stress-ng.time.system_time
 3.349e+10 ±  4%      +3.0%  3.447e+10 ±  2%      +4.1%  3.484e+10        perf-stat.i.branch-instructions
      1.13            -2.1%       1.10            -2.2%       1.10        perf-stat.i.cpi
      0.89            +2.2%       0.91            +2.0%       0.91        perf-stat.i.ipc
      1.04            -6.9%       0.97            -4.9%       0.99        perf-stat.overall.MPKI
      1.13            -2.3%       1.10            -2.0%       1.10        perf-stat.overall.cpi
      1081            +5.0%       1136            +3.0%       1114        perf-stat.overall.cycles-between-cache-misses
      0.89            +2.3%       0.91            +2.0%       0.91        perf-stat.overall.ipc
 3.295e+10 ±  3%      +2.9%  3.392e+10 ±  2%      +4.0%  3.427e+10        perf-stat.ps.branch-instructions
 1.674e+11 ±  3%      +1.8%  1.704e+11 ±  2%      +3.3%   1.73e+11        perf-stat.ps.instructions
 1.046e+13            +2.7%  1.074e+13            +1.7%  1.064e+13        perf-stat.total.instructions
     75.05            -2.0       73.02            -0.9       74.18        perf-profile.calltrace.cycles-pp.move_vma.__do_sys_mremap.do_syscall_64.entry_SYSCALL_64_after_hwframe.mremap
     36.83            -1.6       35.19            -1.2       35.62        perf-profile.calltrace.cycles-pp.do_vmi_align_munmap.do_vmi_munmap.move_vma.__do_sys_mremap.do_syscall_64
     25.02            -1.4       23.65            -0.9       24.12        perf-profile.calltrace.cycles-pp.copy_vma.move_vma.__do_sys_mremap.do_syscall_64.entry_SYSCALL_64_after_hwframe
     19.94            -1.1       18.87            -0.8       19.19        perf-profile.calltrace.cycles-pp.__split_vma.do_vmi_align_munmap.do_vmi_munmap.move_vma.__do_sys_mremap
     14.78            -0.8       14.01            -0.5       14.28        perf-profile.calltrace.cycles-pp.vma_merge.copy_vma.move_vma.__do_sys_mremap.do_syscall_64
      1.48            -0.5        0.99            -0.5        1.00        perf-profile.calltrace.cycles-pp.mas_find.do_vmi_munmap.move_vma.__do_sys_mremap.do_syscall_64
      7.88            -0.4        7.47            -0.3        7.62        perf-profile.calltrace.cycles-pp.move_page_tables.move_vma.__do_sys_mremap.do_syscall_64.entry_SYSCALL_64_after_hwframe
      6.73            -0.4        6.37            -0.2        6.51        perf-profile.calltrace.cycles-pp.vm_area_dup.__split_vma.do_vmi_align_munmap.do_vmi_munmap.move_vma
      6.16            -0.3        5.82            -0.3        5.90        perf-profile.calltrace.cycles-pp.vma_complete.__split_vma.do_vmi_align_munmap.do_vmi_munmap.move_vma
      6.12            -0.3        5.79            -0.2        5.93        perf-profile.calltrace.cycles-pp.kmem_cache_alloc_noprof.vm_area_dup.__split_vma.do_vmi_align_munmap.do_vmi_munmap
      5.79            -0.3        5.48            -0.2        5.59        perf-profile.calltrace.cycles-pp.move_ptes.move_page_tables.move_vma.__do_sys_mremap.do_syscall_64
      5.54            -0.3        5.25            -0.2        5.32        perf-profile.calltrace.cycles-pp.mas_store_prealloc.vma_complete.__split_vma.do_vmi_align_munmap.do_vmi_munmap
      5.56            -0.3        5.28            -0.2        5.36        perf-profile.calltrace.cycles-pp.mas_store_prealloc.vma_merge.copy_vma.move_vma.__do_sys_mremap
      5.19            -0.3        4.92            -0.2        4.98        perf-profile.calltrace.cycles-pp.mas_wr_store_entry.mas_store_prealloc.vma_complete.__split_vma.do_vmi_align_munmap
      5.21            -0.3        4.95            -0.2        5.02        perf-profile.calltrace.cycles-pp.mas_wr_store_entry.mas_store_prealloc.vma_merge.copy_vma.move_vma
      4.09            -0.2        3.85            -0.2        3.93        perf-profile.calltrace.cycles-pp.vm_area_dup.copy_vma.move_vma.__do_sys_mremap.do_syscall_64
      4.69            -0.2        4.46            -0.2        4.51        perf-profile.calltrace.cycles-pp.mas_wr_node_store.mas_wr_store_entry.mas_store_prealloc.vma_merge.copy_vma
      3.56            -0.2        3.36            -0.1        3.43        perf-profile.calltrace.cycles-pp.kmem_cache_alloc_noprof.vm_area_dup.copy_vma.move_vma.__do_sys_mremap
      3.40            -0.2        3.22            -0.1        3.29        perf-profile.calltrace.cycles-pp.flush_tlb_mm_range.move_ptes.move_page_tables.move_vma.__do_sys_mremap
      1.35            -0.2        1.16            -0.1        1.24        perf-profile.calltrace.cycles-pp.mas_find.do_vmi_munmap.do_munmap.mremap_to.__do_sys_mremap
      4.00            -0.2        3.82            -0.1        3.86        perf-profile.calltrace.cycles-pp.mas_wr_node_store.mas_wr_store_entry.mas_store_prealloc.vma_complete.__split_vma
      2.23            -0.2        2.05            -0.1        2.12        perf-profile.calltrace.cycles-pp.find_vma_prev.copy_vma.move_vma.__do_sys_mremap.do_syscall_64
      8.26            -0.2        8.10            -0.2        8.06        perf-profile.calltrace.cycles-pp.unmap_region.do_vmi_align_munmap.do_vmi_munmap.move_vma.__do_sys_mremap
      1.97 ±  3%      -0.2        1.81 ±  3%      -0.1        1.88 ±  4%  perf-profile.calltrace.cycles-pp.mod_objcg_state.__memcg_slab_post_alloc_hook.kmem_cache_alloc_noprof.vm_area_dup.__split_vma
      3.11 ±  2%      -0.2        2.96            -0.1        3.05        perf-profile.calltrace.cycles-pp.__memcg_slab_post_alloc_hook.kmem_cache_alloc_noprof.vm_area_dup.__split_vma.do_vmi_align_munmap
      0.97            -0.2        0.81            -0.1        0.87        perf-profile.calltrace.cycles-pp.mas_walk.mas_find.do_vmi_munmap.do_munmap.mremap_to
      2.27            -0.2        2.11            -0.1        2.16        perf-profile.calltrace.cycles-pp.mas_preallocate.__split_vma.do_vmi_align_munmap.do_vmi_munmap.move_vma
      3.25            -0.1        3.10            -0.1        3.17        perf-profile.calltrace.cycles-pp.mas_store_gfp.do_vmi_align_munmap.do_vmi_munmap.move_vma.__do_sys_mremap
      3.14            -0.1        3.00            -0.1        3.06        perf-profile.calltrace.cycles-pp.unmap_vmas.unmap_region.do_vmi_align_munmap.do_vmi_munmap.move_vma
      2.98            -0.1        2.85            -0.1        2.87 ±  2%  perf-profile.calltrace.cycles-pp.anon_vma_clone.__split_vma.do_vmi_align_munmap.do_vmi_munmap.move_vma
      1.27 ±  2%      -0.1        1.15 ±  4%      -0.1        1.19 ±  6%  perf-profile.calltrace.cycles-pp.__memcpy.mas_wr_node_store.mas_wr_store_entry.mas_store_prealloc.vma_merge
      2.45            -0.1        2.34            -0.1        2.38        perf-profile.calltrace.cycles-pp.flush_tlb_func.flush_tlb_mm_range.move_ptes.move_page_tables.move_vma
      2.05            -0.1        1.94            -0.1        1.97        perf-profile.calltrace.cycles-pp.mas_preallocate.vma_merge.copy_vma.move_vma.__do_sys_mremap
      2.44            -0.1        2.33            -0.1        2.38        perf-profile.calltrace.cycles-pp.unmap_page_range.unmap_vmas.unmap_region.do_vmi_align_munmap.do_vmi_munmap
      2.22            -0.1        2.11            -0.1        2.15        perf-profile.calltrace.cycles-pp.native_flush_tlb_one_user.flush_tlb_func.flush_tlb_mm_range.move_ptes.move_page_tables
      1.76 ±  2%      -0.1        1.65 ±  2%      -0.1        1.66 ±  4%  perf-profile.calltrace.cycles-pp.vma_prepare.vma_merge.copy_vma.move_vma.__do_sys_mremap
      1.86            -0.1        1.75            -0.1        1.78        perf-profile.calltrace.cycles-pp.vma_link.copy_vma.move_vma.__do_sys_mremap.do_syscall_64
      1.40            -0.1        1.30            -0.1        1.34        perf-profile.calltrace.cycles-pp.mas_alloc_nodes.mas_preallocate.__split_vma.do_vmi_align_munmap.do_vmi_munmap
      1.39            -0.1        1.30            -0.1        1.33        perf-profile.calltrace.cycles-pp.mas_alloc_nodes.mas_preallocate.vma_merge.copy_vma.move_vma
      0.55            -0.1        0.46 ± 30%      -0.0        0.52        perf-profile.calltrace.cycles-pp.mas_find.find_vma_prev.copy_vma.move_vma.__do_sys_mremap
      1.25            -0.1        1.16            -0.1        1.20        perf-profile.calltrace.cycles-pp.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_preallocate.__split_vma.do_vmi_align_munmap
      0.94            -0.1        0.86            -0.1        0.87        perf-profile.calltrace.cycles-pp.mas_walk.mas_find.do_vmi_munmap.move_vma.__do_sys_mremap
      1.23            -0.1        1.15            -0.1        1.17        perf-profile.calltrace.cycles-pp.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_preallocate.vma_merge.copy_vma
      1.54            -0.1        1.47            -0.0        1.49        perf-profile.calltrace.cycles-pp.zap_pmd_range.unmap_page_range.unmap_vmas.unmap_region.do_vmi_align_munmap
      0.73            -0.1        0.66            -0.0        0.69        perf-profile.calltrace.cycles-pp.mas_walk.find_vma_prev.copy_vma.move_vma.__do_sys_mremap
      1.15            -0.1        1.09            -0.1        1.10        perf-profile.calltrace.cycles-pp.___slab_alloc.kmem_cache_alloc_noprof.vm_area_dup.__split_vma.do_vmi_align_munmap
      0.60 ±  2%      -0.1        0.54            -0.0        0.58        perf-profile.calltrace.cycles-pp.security_mmap_addr.__get_unmapped_area.mremap_to.__do_sys_mremap.do_syscall_64
      1.27            -0.1        1.21            -0.0        1.24        perf-profile.calltrace.cycles-pp.mas_wr_store_entry.mas_store_gfp.do_vmi_align_munmap.do_vmi_munmap.move_vma
      0.80 ±  2%      -0.1        0.74 ±  2%      -0.0        0.76 ±  2%  perf-profile.calltrace.cycles-pp.__call_rcu_common.mas_wr_node_store.mas_wr_store_entry.mas_store_prealloc.vma_merge
      0.72            -0.1        0.66            -0.0        0.69        perf-profile.calltrace.cycles-pp.mas_prev.vma_merge.copy_vma.move_vma.__do_sys_mremap
      0.78            -0.1        0.73            -0.0        0.75        perf-profile.calltrace.cycles-pp.___slab_alloc.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_preallocate.__split_vma
      0.69 ±  2%      -0.1        0.64 ±  3%      -0.0        0.66 ±  4%  perf-profile.calltrace.cycles-pp.mod_objcg_state.__memcg_slab_post_alloc_hook.kmem_cache_alloc_noprof.vm_area_dup.copy_vma
      1.63            -0.1        1.58            -0.1        1.57        perf-profile.calltrace.cycles-pp.__get_unmapped_area.mremap_to.__do_sys_mremap.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.02            -0.1        0.97            -0.0        0.98        perf-profile.calltrace.cycles-pp.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas.unmap_region
      0.77            -0.0        0.72            -0.0        0.74        perf-profile.calltrace.cycles-pp.___slab_alloc.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_preallocate.vma_merge
      0.62            -0.0        0.57            -0.0        0.60        perf-profile.calltrace.cycles-pp.mas_prev_setup.mas_prev.vma_merge.copy_vma.move_vma
      0.67            -0.0        0.62            -0.0        0.64        perf-profile.calltrace.cycles-pp.percpu_counter_add_batch.do_vmi_align_munmap.do_vmi_munmap.move_vma.__do_sys_mremap
      0.86            -0.0        0.81            -0.0        0.83        perf-profile.calltrace.cycles-pp.mtree_load.vma_to_resize.mremap_to.__do_sys_mremap.do_syscall_64
      1.12            -0.0        1.08            -0.0        1.09        perf-profile.calltrace.cycles-pp.clear_bhb_loop.mremap
      0.56            -0.0        0.51            -0.0        0.53        perf-profile.calltrace.cycles-pp.mas_walk.mas_prev_setup.mas_prev.vma_merge.copy_vma
      0.68 ±  2%      -0.0        0.63            -0.0        0.65        perf-profile.calltrace.cycles-pp.syscall_return_via_sysret.mremap
      0.81            -0.0        0.77            -0.0        0.80        perf-profile.calltrace.cycles-pp.mtree_load.__do_sys_mremap.do_syscall_64.entry_SYSCALL_64_after_hwframe.mremap
      1.02            -0.0        0.97            -0.0        0.98        perf-profile.calltrace.cycles-pp.vma_to_resize.mremap_to.__do_sys_mremap.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.95 ±  2%      -0.0        0.90 ±  2%      -0.0        0.93        perf-profile.calltrace.cycles-pp.__memcg_slab_free_hook.kmem_cache_free.unlink_anon_vmas.free_pgtables.unmap_region
      0.98            -0.0        0.94            -0.0        0.95        perf-profile.calltrace.cycles-pp.mas_find.do_vmi_align_munmap.do_vmi_munmap.move_vma.__do_sys_mremap
      0.78            -0.0        0.74            -0.0        0.75        perf-profile.calltrace.cycles-pp.mas_store_prealloc.vma_link.copy_vma.move_vma.__do_sys_mremap
      0.70            -0.0        0.66            -0.0        0.67        perf-profile.calltrace.cycles-pp.__call_rcu_common.do_vmi_align_munmap.do_vmi_munmap.move_vma.__do_sys_mremap
      0.69            -0.0        0.65            -0.0        0.66        perf-profile.calltrace.cycles-pp.___slab_alloc.kmem_cache_alloc_noprof.vm_area_dup.copy_vma.move_vma
      0.69            -0.0        0.65            -0.0        0.65        perf-profile.calltrace.cycles-pp.mas_preallocate.vma_link.copy_vma.move_vma.__do_sys_mremap
      0.62            -0.0        0.59            -0.0        0.60        perf-profile.calltrace.cycles-pp.mas_prev_slot.do_vmi_align_munmap.do_vmi_munmap.move_vma.__do_sys_mremap
      1.16            -0.0        1.12            -0.0        1.13        perf-profile.calltrace.cycles-pp.anon_vma_clone.copy_vma.move_vma.__do_sys_mremap.do_syscall_64
      0.76 ±  2%      -0.0        0.72            -0.0        0.72 ±  2%  perf-profile.calltrace.cycles-pp.allocate_slab.___slab_alloc.kmem_cache_alloc_noprof.vm_area_dup.__split_vma
      1.01            -0.0        0.97            -0.0        0.99        perf-profile.calltrace.cycles-pp.mt_find.vma_merge.copy_vma.move_vma.__do_sys_mremap
      0.60            -0.0        0.57            -0.0        0.58        perf-profile.calltrace.cycles-pp.__pte_offset_map_lock.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas
      0.88            -0.0        0.85            -0.0        0.85        perf-profile.calltrace.cycles-pp.userfaultfd_unmap_complete.__do_sys_mremap.do_syscall_64.entry_SYSCALL_64_after_hwframe.mremap
      0.62 ±  2%      -0.0        0.59 ±  2%      -0.0        0.60        perf-profile.calltrace.cycles-pp.get_old_pud.move_page_tables.move_vma.__do_sys_mremap.do_syscall_64
      0.59            -0.0        0.56            -0.0        0.56        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64.mremap
      0.65            -0.0        0.62 ±  2%      -0.0        0.63        perf-profile.calltrace.cycles-pp.mas_update_gap.mas_store_gfp.do_vmi_align_munmap.do_vmi_munmap.move_vma
      0.81            +0.0        0.82            -0.0        0.79        perf-profile.calltrace.cycles-pp.thp_get_unmapped_area_vmflags.__get_unmapped_area.mremap_to.__do_sys_mremap.do_syscall_64
      2.76            +0.0        2.78 ±  2%      -0.1        2.67        perf-profile.calltrace.cycles-pp.unlink_anon_vmas.free_pgtables.unmap_region.do_vmi_align_munmap.do_vmi_munmap
      3.47            +0.0        3.51            -0.1        3.37        perf-profile.calltrace.cycles-pp.free_pgtables.unmap_region.do_vmi_align_munmap.do_vmi_munmap.move_vma
      0.76            +0.1        0.83            +0.1        0.85        perf-profile.calltrace.cycles-pp.__madvise
      0.66            +0.1        0.73            +0.1        0.75        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__madvise
      0.67            +0.1        0.74            +0.1        0.76        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__madvise
      0.63            +0.1        0.70            +0.1        0.72        perf-profile.calltrace.cycles-pp.__x64_sys_madvise.do_syscall_64.entry_SYSCALL_64_after_hwframe.__madvise
      0.62            +0.1        0.70            +0.1        0.71        perf-profile.calltrace.cycles-pp.do_madvise.__x64_sys_madvise.do_syscall_64.entry_SYSCALL_64_after_hwframe.__madvise
      0.00            +0.9        0.86            +0.9        0.92        perf-profile.calltrace.cycles-pp.mas_walk.mas_find.can_modify_mm.do_vmi_munmap.do_munmap
      0.00            +0.9        0.88            +0.0        0.00        perf-profile.calltrace.cycles-pp.mas_walk.mas_find.can_modify_mm.mremap_to.__do_sys_mremap
     83.81            +0.9       84.69            +0.6       84.44        perf-profile.calltrace.cycles-pp.__do_sys_mremap.do_syscall_64.entry_SYSCALL_64_after_hwframe.mremap
      0.00            +0.9        0.90 ±  2%      +0.9        0.91        perf-profile.calltrace.cycles-pp.mas_walk.mas_find.can_modify_mm.do_vmi_munmap.move_vma
      0.00            +1.1        1.10            +0.0        0.00        perf-profile.calltrace.cycles-pp.mas_find.can_modify_mm.mremap_to.__do_sys_mremap.do_syscall_64
      0.00            +1.2        1.21            +1.3        1.28        perf-profile.calltrace.cycles-pp.mas_find.can_modify_mm.do_vmi_munmap.do_munmap.mremap_to
      2.10            +1.5        3.60            +1.7        3.79        perf-profile.calltrace.cycles-pp.do_munmap.mremap_to.__do_sys_mremap.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +1.5        1.52            +1.5        1.52        perf-profile.calltrace.cycles-pp.mas_find.can_modify_mm.do_vmi_munmap.move_vma.__do_sys_mremap
      1.59            +1.5        3.12            +1.7        3.31        perf-profile.calltrace.cycles-pp.do_vmi_munmap.do_munmap.mremap_to.__do_sys_mremap.do_syscall_64
      0.00            +1.6        1.61            +0.0        0.00        perf-profile.calltrace.cycles-pp.can_modify_mm.mremap_to.__do_sys_mremap.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +1.7        1.73            +1.8        1.83        perf-profile.calltrace.cycles-pp.can_modify_mm.do_vmi_munmap.do_munmap.mremap_to.__do_sys_mremap
      0.00            +2.0        2.01            +2.0        2.04        perf-profile.calltrace.cycles-pp.can_modify_mm.do_vmi_munmap.move_vma.__do_sys_mremap.do_syscall_64
      5.34            +3.0        8.38            +1.6        6.92        perf-profile.calltrace.cycles-pp.mremap_to.__do_sys_mremap.do_syscall_64.entry_SYSCALL_64_after_hwframe.mremap
     75.22            -2.0       73.18            -0.9       74.34        perf-profile.children.cycles-pp.move_vma
     37.04            -1.6       35.40            -1.2       35.83        perf-profile.children.cycles-pp.do_vmi_align_munmap
     25.09            -1.4       23.72            -0.9       24.20        perf-profile.children.cycles-pp.copy_vma
     20.04            -1.1       18.96            -0.8       19.28        perf-profile.children.cycles-pp.__split_vma
     19.87            -1.0       18.84            -0.6       19.24        perf-profile.children.cycles-pp.rcu_core
     19.85            -1.0       18.82            -0.6       19.22        perf-profile.children.cycles-pp.rcu_do_batch
     19.89            -1.0       18.86            -0.6       19.26        perf-profile.children.cycles-pp.handle_softirqs
     17.55            -0.9       16.67            -0.5       17.02        perf-profile.children.cycles-pp.kmem_cache_free
     15.32            -0.8       14.49            -0.5       14.78        perf-profile.children.cycles-pp.kmem_cache_alloc_noprof
     15.17            -0.8       14.39            -0.5       14.66        perf-profile.children.cycles-pp.vma_merge
     12.12            -0.6       11.48            -0.4       11.70        perf-profile.children.cycles-pp.__slab_free
     12.19            -0.6       11.56            -0.5       11.73        perf-profile.children.cycles-pp.mas_wr_store_entry
     11.99            -0.6       11.36            -0.5       11.53        perf-profile.children.cycles-pp.mas_store_prealloc
     10.88            -0.6       10.28            -0.4       10.50        perf-profile.children.cycles-pp.vm_area_dup
      9.90            -0.5        9.41            -0.4        9.53        perf-profile.children.cycles-pp.mas_wr_node_store
      8.39            -0.5        7.92            -0.3        8.13        perf-profile.children.cycles-pp.__memcg_slab_post_alloc_hook
      7.99            -0.4        7.58            -0.3        7.73        perf-profile.children.cycles-pp.move_page_tables
      6.70            -0.4        6.33            -0.3        6.43        perf-profile.children.cycles-pp.vma_complete
      5.87            -0.3        5.55            -0.2        5.66        perf-profile.children.cycles-pp.move_ptes
      5.12            -0.3        4.81            -0.2        4.90        perf-profile.children.cycles-pp.mas_preallocate
      6.05            -0.3        5.74            -0.2        5.85        perf-profile.children.cycles-pp.vm_area_free_rcu_cb
      2.98            -0.3        2.69 ±  4%      -0.2        2.80 ±  6%  perf-profile.children.cycles-pp.__memcpy
      3.46 ±  2%      -0.2        3.25            -0.1        3.36 ±  3%  perf-profile.children.cycles-pp.mod_objcg_state
      3.47            -0.2        3.26            -0.2        3.32        perf-profile.children.cycles-pp.___slab_alloc
      2.44            -0.2        2.25            -0.1        2.33        perf-profile.children.cycles-pp.find_vma_prev
      2.92            -0.2        2.73            -0.1        2.79        perf-profile.children.cycles-pp.mas_alloc_nodes
      3.46            -0.2        3.27            -0.1        3.34        perf-profile.children.cycles-pp.flush_tlb_mm_range
      3.47            -0.2        3.29            -0.2        3.32 ±  2%  perf-profile.children.cycles-pp.down_write
      3.33            -0.2        3.16            -0.1        3.25        perf-profile.children.cycles-pp.__memcg_slab_free_hook
      4.23            -0.2        4.07            -0.1        4.08 ±  2%  perf-profile.children.cycles-pp.anon_vma_clone
      8.33            -0.2        8.17            -0.2        8.13        perf-profile.children.cycles-pp.unmap_region
      3.35            -0.1        3.20            -0.1        3.26        perf-profile.children.cycles-pp.mas_store_gfp
      2.21            -0.1        2.07            -0.1        2.10        perf-profile.children.cycles-pp.__cond_resched
      3.19            -0.1        3.05            -0.1        3.11        perf-profile.children.cycles-pp.unmap_vmas
      2.12            -0.1        1.99            -0.1        2.04        perf-profile.children.cycles-pp.__call_rcu_common
      2.66            -0.1        2.54            -0.1        2.60        perf-profile.children.cycles-pp.mtree_load
      2.24            -0.1        2.12 ±  2%      -0.1        2.13 ±  3%  perf-profile.children.cycles-pp.vma_prepare
      2.50            -0.1        2.38            -0.1        2.42        perf-profile.children.cycles-pp.flush_tlb_func
      2.04 ±  2%      -0.1        1.93            -0.1        1.96 ±  2%  perf-profile.children.cycles-pp.allocate_slab
      2.46            -0.1        2.35            -0.1        2.41        perf-profile.children.cycles-pp.rcu_cblist_dequeue
      2.48            -0.1        2.38            -0.1        2.42        perf-profile.children.cycles-pp.unmap_page_range
      2.23            -0.1        2.12            -0.1        2.16        perf-profile.children.cycles-pp.native_flush_tlb_one_user
      1.77            -0.1        1.67            -0.1        1.70        perf-profile.children.cycles-pp.mas_wr_walk
      1.88            -0.1        1.78            -0.1        1.80        perf-profile.children.cycles-pp.vma_link
      1.84            -0.1        1.75            -0.1        1.77        perf-profile.children.cycles-pp.up_write
      0.97 ±  2%      -0.1        0.88            -0.1        0.89        perf-profile.children.cycles-pp.rcu_all_qs
      1.40            -0.1        1.32            -0.1        1.34 ±  2%  perf-profile.children.cycles-pp.shuffle_freelist
      1.03            -0.1        0.95            -0.0        0.99        perf-profile.children.cycles-pp.mas_prev
      0.92            -0.1        0.85            -0.0        0.88        perf-profile.children.cycles-pp.mas_prev_setup
      1.58            -0.1        1.51            -0.1        1.53        perf-profile.children.cycles-pp.zap_pmd_range
      1.24            -0.1        1.17            -0.0        1.20        perf-profile.children.cycles-pp.mas_prev_slot
      1.57            -0.1        1.49            -0.1        1.49        perf-profile.children.cycles-pp.mas_update_gap
      0.62            -0.1        0.56            -0.0        0.60        perf-profile.children.cycles-pp.security_mmap_addr
      0.90            -0.1        0.84            -0.0        0.86        perf-profile.children.cycles-pp.percpu_counter_add_batch
      0.86            -0.1        0.80            -0.0        0.81        perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.98            -0.1        0.92            -0.0        0.95        perf-profile.children.cycles-pp.mas_pop_node
      1.68            -0.1        1.62            -0.1        1.62        perf-profile.children.cycles-pp.__get_unmapped_area
      1.23            -0.1        1.18            -0.0        1.20        perf-profile.children.cycles-pp.__pte_offset_map_lock
      0.49 ±  2%      -0.1        0.43            -0.1        0.43 ±  2%  perf-profile.children.cycles-pp.setup_object
      1.09            -0.1        1.03            -0.0        1.05        perf-profile.children.cycles-pp.zap_pte_range
      1.07 ±  2%      -0.1        1.02 ±  2%      -0.1        1.00        perf-profile.children.cycles-pp.mas_leaf_max_gap
      0.70 ±  2%      -0.0        0.65            -0.0        0.67        perf-profile.children.cycles-pp.syscall_return_via_sysret
      1.18            -0.0        1.14            -0.0        1.15        perf-profile.children.cycles-pp.clear_bhb_loop
      0.51 ±  3%      -0.0        0.47            -0.0        0.49 ±  3%  perf-profile.children.cycles-pp.anon_vma_interval_tree_insert
      1.04            -0.0        1.00            -0.0        1.01        perf-profile.children.cycles-pp.vma_to_resize
      0.57            -0.0        0.53            -0.0        0.54        perf-profile.children.cycles-pp.mas_wr_end_piv
      0.44 ±  2%      -0.0        0.40 ±  2%      -0.0        0.40        perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      1.14            -0.0        1.10            -0.0        1.12        perf-profile.children.cycles-pp.mt_find
      0.90            -0.0        0.87            -0.0        0.87        perf-profile.children.cycles-pp.userfaultfd_unmap_complete
      0.62            -0.0        0.59            -0.0        0.60        perf-profile.children.cycles-pp.__put_partials
      0.45 ±  6%      -0.0        0.42            -0.0        0.43        perf-profile.children.cycles-pp._raw_spin_lock
      0.48            -0.0        0.45 ±  2%      -0.0        0.46        perf-profile.children.cycles-pp.mas_prev_range
      0.61            -0.0        0.58            -0.0        0.59        perf-profile.children.cycles-pp.entry_SYSCALL_64
      0.31 ±  3%      -0.0        0.28 ±  3%      -0.0        0.31        perf-profile.children.cycles-pp.security_vm_enough_memory_mm
      0.33 ±  3%      -0.0        0.30 ±  2%      -0.0        0.31 ±  4%  perf-profile.children.cycles-pp.mas_put_in_tree
      0.32 ±  2%      -0.0        0.29 ±  2%      -0.0        0.30        perf-profile.children.cycles-pp.tlb_finish_mmu
      0.46            -0.0        0.44 ±  2%      -0.0        0.46        perf-profile.children.cycles-pp.rcu_segcblist_enqueue
      0.33            -0.0        0.31            -0.0        0.32        perf-profile.children.cycles-pp.mas_destroy
      0.36            -0.0        0.34            -0.0        0.34        perf-profile.children.cycles-pp.__rb_insert_augmented
      0.39            -0.0        0.37            -0.0        0.38 ±  2%  perf-profile.children.cycles-pp.down_write_killable
      0.29            -0.0        0.27 ±  2%      -0.0        0.28        perf-profile.children.cycles-pp.tlb_gather_mmu
      0.26            -0.0        0.24 ±  2%      -0.0        0.25 ±  2%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.16 ±  2%      -0.0        0.14 ±  3%      -0.0        0.14 ±  3%  perf-profile.children.cycles-pp.mas_wr_append
      0.30 ±  2%      -0.0        0.28 ±  2%      -0.0        0.29 ±  2%  perf-profile.children.cycles-pp.__vm_enough_memory
      0.32            -0.0        0.30 ±  2%      -0.0        0.31        perf-profile.children.cycles-pp.pte_offset_map_nolock
      2.83            +0.0        2.85 ±  2%      -0.1        2.74        perf-profile.children.cycles-pp.unlink_anon_vmas
      0.84            +0.0        0.86            -0.0        0.81        perf-profile.children.cycles-pp.thp_get_unmapped_area_vmflags
      0.08 ±  5%      +0.0        0.10 ±  3%      -0.0        0.08 ±  6%  perf-profile.children.cycles-pp.mm_get_unmapped_area_vmflags
      3.52            +0.0        3.56            -0.1        3.42        perf-profile.children.cycles-pp.free_pgtables
      0.78            +0.1        0.85            +0.1        0.86        perf-profile.children.cycles-pp.__madvise
      0.63            +0.1        0.70            +0.1        0.72        perf-profile.children.cycles-pp.__x64_sys_madvise
      0.63            +0.1        0.70            +0.1        0.71        perf-profile.children.cycles-pp.do_madvise
      0.00            +0.1        0.09 ±  3%      +0.1        0.10 ±  5%  perf-profile.children.cycles-pp.can_modify_mm_madv
      1.31            +0.2        1.46            +0.2        1.50        perf-profile.children.cycles-pp.mas_next_slot
     83.90            +0.9       84.79            +0.6       84.53        perf-profile.children.cycles-pp.__do_sys_mremap
     40.45            +1.4       41.90            +2.1       42.57        perf-profile.children.cycles-pp.do_vmi_munmap
      2.12            +1.5        3.62            +1.7        3.82        perf-profile.children.cycles-pp.do_munmap
      3.63            +2.4        5.98            +1.7        5.29        perf-profile.children.cycles-pp.mas_walk
      5.40            +3.0        8.44            +1.6        6.97        perf-profile.children.cycles-pp.mremap_to
      5.26            +3.2        8.48            +2.3        7.58        perf-profile.children.cycles-pp.mas_find
      0.00            +5.5        5.46            +3.9        3.93        perf-profile.children.cycles-pp.can_modify_mm
     11.49            -0.6       10.89            -0.4       11.10        perf-profile.self.cycles-pp.__slab_free
      4.32            -0.3        4.06            -0.2        4.16        perf-profile.self.cycles-pp.__memcg_slab_post_alloc_hook
      1.96            -0.2        1.77 ±  4%      -0.1        1.84 ±  6%  perf-profile.self.cycles-pp.__memcpy
      2.36            -0.1        2.25 ±  2%      -0.1        2.25 ±  3%  perf-profile.self.cycles-pp.down_write
      2.42            -0.1        2.31            -0.0        2.38        perf-profile.self.cycles-pp.rcu_cblist_dequeue
      2.33            -0.1        2.23            -0.1        2.28        perf-profile.self.cycles-pp.mtree_load
      2.21            -0.1        2.10            -0.1        2.14        perf-profile.self.cycles-pp.native_flush_tlb_one_user
      1.62            -0.1        1.54            -0.0        1.57        perf-profile.self.cycles-pp.__memcg_slab_free_hook
      1.52            -0.1        1.44            -0.1        1.46        perf-profile.self.cycles-pp.mas_wr_walk
      1.44            -0.1        1.36            -0.1        1.38 ±  2%  perf-profile.self.cycles-pp.__call_rcu_common
      1.53            -0.1        1.45            -0.0        1.48        perf-profile.self.cycles-pp.up_write
      1.72            -0.1        1.65            -0.0        1.70        perf-profile.self.cycles-pp.mod_objcg_state
      0.69 ±  2%      -0.1        0.63            -0.1        0.63        perf-profile.self.cycles-pp.rcu_all_qs
      1.14 ±  2%      -0.1        1.08            -0.0        1.09 ±  2%  perf-profile.self.cycles-pp.shuffle_freelist
      1.18            -0.1        1.12            -0.0        1.17        perf-profile.self.cycles-pp.vma_merge
      1.38            -0.1        1.33            -0.0        1.35        perf-profile.self.cycles-pp.do_vmi_align_munmap
      0.51 ±  2%      -0.1        0.45            -0.0        0.49        perf-profile.self.cycles-pp.security_mmap_addr
      0.62            -0.1        0.56 ±  2%      -0.1        0.56        perf-profile.self.cycles-pp.mremap
      0.89            -0.1        0.83            -0.0        0.85        perf-profile.self.cycles-pp.___slab_alloc
      0.99            -0.1        0.94            -0.0        0.96        perf-profile.self.cycles-pp.mas_prev_slot
      1.00            -0.0        0.95            -0.0        0.96        perf-profile.self.cycles-pp.mas_preallocate
      0.98            -0.0        0.93            -0.0        0.95        perf-profile.self.cycles-pp.move_ptes
      0.85            -0.0        0.80            -0.0        0.82        perf-profile.self.cycles-pp.mas_pop_node
      0.94            -0.0        0.90            -0.0        0.91 ±  2%  perf-profile.self.cycles-pp.vm_area_free_rcu_cb
      1.09            -0.0        1.04            -0.0        1.06        perf-profile.self.cycles-pp.__cond_resched
      0.77            -0.0        0.72            -0.0        0.74        perf-profile.self.cycles-pp.percpu_counter_add_batch
      0.94 ±  2%      -0.0        0.89 ±  2%      -0.1        0.87        perf-profile.self.cycles-pp.mas_leaf_max_gap
      1.17            -0.0        1.12            -0.0        1.14        perf-profile.self.cycles-pp.clear_bhb_loop
      0.68            -0.0        0.63            -0.0        0.65        perf-profile.self.cycles-pp.__split_vma
      0.79            -0.0        0.75            -0.0        0.77        perf-profile.self.cycles-pp.mas_wr_store_entry
      1.22            -0.0        1.18            -0.0        1.18        perf-profile.self.cycles-pp.move_vma
      0.43 ±  2%      -0.0        0.40 ±  2%      -0.0        0.40        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      1.49            -0.0        1.45            +0.0        1.49        perf-profile.self.cycles-pp.kmem_cache_free
      0.44            -0.0        0.40            -0.0        0.40        perf-profile.self.cycles-pp.do_munmap
      0.45            -0.0        0.42            -0.0        0.43        perf-profile.self.cycles-pp.mas_wr_end_piv
      0.89            -0.0        0.86            -0.0        0.88        perf-profile.self.cycles-pp.mas_store_gfp
      0.78            -0.0        0.75            -0.0        0.76        perf-profile.self.cycles-pp.userfaultfd_unmap_complete
      0.66            -0.0        0.62            -0.0        0.64        perf-profile.self.cycles-pp.mas_store_prealloc
      0.60            -0.0        0.58            -0.0        0.59        perf-profile.self.cycles-pp.unmap_region
      0.36 ±  4%      -0.0        0.33 ±  3%      -0.0        0.34 ±  2%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.55            -0.0        0.52            -0.0        0.53        perf-profile.self.cycles-pp.get_old_pud
      0.99            -0.0        0.97            -0.0        0.98        perf-profile.self.cycles-pp.mt_find
      0.61            -0.0        0.58            -0.0        0.60        perf-profile.self.cycles-pp.copy_vma
      0.43 ±  3%      -0.0        0.40            -0.0        0.41 ±  4%  perf-profile.self.cycles-pp.anon_vma_interval_tree_insert
      0.49            -0.0        0.47            -0.0        0.48        perf-profile.self.cycles-pp.find_vma_prev
      0.71            -0.0        0.68            -0.0        0.70        perf-profile.self.cycles-pp.unmap_page_range
      0.27            -0.0        0.25            -0.0        0.26        perf-profile.self.cycles-pp.mas_prev_setup
      0.47            -0.0        0.45            -0.0        0.46 ±  2%  perf-profile.self.cycles-pp.flush_tlb_mm_range
      0.37 ±  6%      -0.0        0.35            -0.0        0.35        perf-profile.self.cycles-pp._raw_spin_lock
      0.41            -0.0        0.39            -0.0        0.40        perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.40            -0.0        0.37            -0.0        0.38        perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.27            -0.0        0.25 ±  2%      -0.0        0.25 ±  3%  perf-profile.self.cycles-pp.mas_put_in_tree
      0.49            -0.0        0.47            -0.0        0.49        perf-profile.self.cycles-pp.refill_obj_stock
      0.48            -0.0        0.46            -0.0        0.47        perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.27 ±  2%      -0.0        0.25            -0.0        0.26        perf-profile.self.cycles-pp.tlb_finish_mmu
      0.24 ±  2%      -0.0        0.22            -0.0        0.23        perf-profile.self.cycles-pp.mas_prev
      0.28            -0.0        0.26            -0.0        0.27 ±  2%  perf-profile.self.cycles-pp.mas_alloc_nodes
      0.40            -0.0        0.39            -0.0        0.40        perf-profile.self.cycles-pp.__pte_offset_map_lock
      0.14 ±  3%      -0.0        0.12 ±  2%      -0.0        0.13 ±  3%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      0.26            -0.0        0.24 ±  2%      -0.0        0.25        perf-profile.self.cycles-pp.__rb_insert_augmented
      0.28            -0.0        0.26            -0.0        0.27        perf-profile.self.cycles-pp.alloc_new_pud
      0.28            -0.0        0.26            -0.0        0.27 ±  2%  perf-profile.self.cycles-pp.flush_tlb_func
      0.20 ±  2%      -0.0        0.19            -0.0        0.19 ±  2%  perf-profile.self.cycles-pp.__get_unmapped_area
      0.47            -0.0        0.46            -0.0        0.45        perf-profile.self.cycles-pp.arch_get_unmapped_area_topdown_vmflags
      0.06            -0.0        0.05 ±  5%      -0.0        0.05        perf-profile.self.cycles-pp.vma_dup_policy
      0.06 ±  6%      +0.0        0.07            -0.0        0.06 ±  8%  perf-profile.self.cycles-pp.mm_get_unmapped_area_vmflags
      0.11 ±  4%      +0.0        0.12 ±  4%      +0.0        0.12 ±  4%  perf-profile.self.cycles-pp.free_pgd_range
      0.21            +0.0        0.22 ±  2%      -0.0        0.20 ±  2%  perf-profile.self.cycles-pp.thp_get_unmapped_area_vmflags
      0.45            +0.0        0.48            +0.0        0.50        perf-profile.self.cycles-pp.do_vmi_munmap
      0.27            +0.0        0.32            -0.0        0.26        perf-profile.self.cycles-pp.free_pgtables
      0.36 ±  2%      +0.1        0.44            -0.0        0.35        perf-profile.self.cycles-pp.unlink_anon_vmas
      1.07            +0.1        1.19            +0.2        1.22        perf-profile.self.cycles-pp.mas_next_slot
      1.49            +0.5        2.01            +0.4        1.86        perf-profile.self.cycles-pp.mas_find
      0.00            +1.4        1.37            +0.9        0.93        perf-profile.self.cycles-pp.can_modify_mm
      3.14            +2.1        5.23            +1.5        4.60        perf-profile.self.cycles-pp.mas_walk


> 
> 
> > 
> > to avoid the impact of other changes, better to apply the patch upon 8be7258a
> > directly.
> > 
> > if you prefer other base for this patch, please let us know. then we will
> > supply the results for 4 commits in fact:
> > 
> > this patch
> > the base of this patch
> > 8be7258a: mseal: add mseal syscall
> > ff388fe5c: mseal: wire up mseal syscall
> > 
> > > 
> > > > >
> > > > > Thank you for your time and assistance in helping me on understanding
> > > > > this issue.
> > > >
> > > > due to resource constraint, please expect that we need several days to finish
> > > > this test request.
> > > No problem.
> > > 
> > > Thanks for your help!
> > > -Jeff
> > > 
> > > > >
> > > > > Best regards,
> > > > > -Jeff
> > > > >
> > > > > > -Jeff
> > > > > >
> > > > > > > [1] https://lore.kernel.org/lkml/202408041602.caa0372-oliver.sang@intel.com/
> > > > > > > [2] https://github.com/peaktocreek/mmperf/blob/main/run_stress_ng.c
> > > > > > >
> > > > > > >
> > > > > > > Jeff Xu (2):
> > > > > > >   mseal:selftest mremap across VMA boundaries.
> > > > > > >   mseal: refactor mremap to remove can_modify_mm
> > > > > > >
> > > > > > >  mm/internal.h                           |  24 ++
> > > > > > >  mm/mremap.c                             |  77 +++----
> > > > > > >  mm/mseal.c                              |  17 --
> > > > > > >  tools/testing/selftests/mm/mseal_test.c | 293 +++++++++++++++++++++++-
> > > > > > >  4 files changed, 353 insertions(+), 58 deletions(-)
> > > > > > >
> > > > > > > --
> > > > > > > 2.46.0.76.ge559c4bf1a-goog
> > > > > > >

