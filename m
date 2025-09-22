Return-Path: <linux-kselftest+bounces-42077-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 290B9B9279B
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Sep 2025 19:49:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3D8617B96D
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Sep 2025 17:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 845D73168F5;
	Mon, 22 Sep 2025 17:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OTH/Y4RP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013005.outbound.protection.outlook.com [40.93.201.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18763168E2;
	Mon, 22 Sep 2025 17:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758563343; cv=fail; b=AY9KOhdDYnQOpMeoLAVNLOeORwfEf4mm/B6apEaCk94RHNk012rEOrPLoPCEO/ad7ACXn/aIyKtjze57VMNRIJ0W+0OVEVKJt3ehvXWBm2VEHnUkteisKkzd+lljZv/sERnkZ+hB2zNAVlO0xZBDliP6D3iG6xeJQ3NrVIjPgAA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758563343; c=relaxed/simple;
	bh=WZNJgdYuNZt+1cfDxeaTOa1zKaHu9wbGgRaAF/2KWJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jvUoyij+9qSwpGC4JoSqnGMF4gBvGqBkZGojbX8+kSEntjPAI+ohk2JI1u9gQkvHWZzCK9SLVuxjVtp3yGdkPvecOp9RaupDoILmWr3H0COvRmp1Jndp4diRb+EJOpgay0pkbEcNl/y78dCPAkxvxPjgy5+K6TGpL/vARU24vCI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OTH/Y4RP; arc=fail smtp.client-ip=40.93.201.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kgGV+srlOAMRB7JczLvRtRw8BK4hl1lI0fIdxkg3cHGDUziCLmz/aYmYxsmAyFz37m357BRXQfFMkCsaQvsyOQ7/Y7Ym0iA7JurTTTn6cNAU1nTjSM2qaUZ53ig0xUG8I92PSEgMS20wRENygsDGX49coaXsfqNUYyXD9yQRfeY0jUMJI8ocpo7T0jlridg0V7mPKcXHRLEsjDURDIn4tVYZt7srT4jw/ZpZ80mMvYdB+eS2LvvCQqLxo/o1O1D7zfHHz2y60JC07QV9UwFSwDgXPpQjTHwX9tQh/IJ5eCjYi2dfOhTWUTTl7X6ZZbSFbDoT+fvMTptzZVlE3HBSfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9L4g21h6Vs3xDzjKY+wJNqvlHLdWtCalCRo+seuy7f4=;
 b=RbcGrWz7C/38Mj1kcdoAj7nT4E5/7abSjduJQtERidM7/XfAMlUOJ1uSb5NMML16rpxXsBId+173La6OhEVE9KB3PcVCvEQfGasgxBekIy9XHHgjph73TiXkTAAgT+au8l6Tix0xjLRuaPkq1MZkzZ7MpK63frGubZiyJfivXmwv6++CzSvydEDuuu5iKGqbPtVgSgduvVrsrt1+UVYF7k2p4RK82/4JRVsA+1nLpf7qVCLfhYYGYFgm1ySIsATqqWX0Ou3xC0xmDWmrI//UDjxlmwOv52qJlux7eVyhkEyJjAuvWybn17DOtEL4njcYc1Zq3F6YoCP+ace3bpDrCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9L4g21h6Vs3xDzjKY+wJNqvlHLdWtCalCRo+seuy7f4=;
 b=OTH/Y4RPjLXggqwF2uXW0zzQ4i9HyJ1aT0cOXY1/8HKPcKaZF3VWUacHC8gw6AOjlTB+PGCt3Fkzz3OlxgiS/Eyk2LfAlhciC27ojOoZdtni8y2hJ/4sAz4989tIRKjRUreSZYpb96AnN2mkX54BP7p9ATvzW8jnSl38AYZCMT6Qu+gh13dxX0hlHW63cpt3Zgz6pgSExjipuDJqXcbdbKLngOZYs5VKE3Cfazzvs1KbdwmfCSQd9FeQmZtBb/XStR1LfU8oo3kUlOBqaj/q7lWlcV9m+LzR9XQ28keG+/wA1iQfiYbR/ELzYmLzfSttQdMQzco68zoO4aMEhcXE/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by DS7PR12MB9552.namprd12.prod.outlook.com (2603:10b6:8:24f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Mon, 22 Sep
 2025 17:49:00 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9137.018; Mon, 22 Sep 2025
 17:48:59 +0000
Date: Mon, 22 Sep 2025 14:40:10 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Benson Leung <bleung@chromium.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	Dawid Niedzwiecki <dawidn@google.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v3 0/5] platform/chrome: Fix a possible UAF via revocable
Message-ID: <20250922174010.GC1391379@nvidia.com>
References: <CACMJSeuKH+WKOXLNU92dMssqhK02xG3z=cT0VeXYM+ZGuPCB9g@mail.gmail.com>
 <aMQW2jUFlx7Iu9U5@tzungbi-laptop>
 <20250912132656.GC31682@pendragon.ideasonboard.com>
 <2025091209-curfew-safari-f6e0@gregkh>
 <CAMRc=MfdoB50o=3Q2p94o+f7S2Bzr=TAtWWQcDrC5Wf3Q5nqAA@mail.gmail.com>
 <20250912135916.GF31682@pendragon.ideasonboard.com>
 <2025091220-private-verse-d979@gregkh>
 <20250912142646.GI31682@pendragon.ideasonboard.com>
 <20250922151040.GA2546062@nvidia.com>
 <DCZG9N3QIRNP.1HUDPVL61FZVR@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DCZG9N3QIRNP.1HUDPVL61FZVR@kernel.org>
X-ClientProxiedBy: SA1P222CA0110.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c5::22) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|DS7PR12MB9552:EE_
X-MS-Office365-Filtering-Correlation-Id: dd9d13c9-e9a4-4dc8-7386-08ddfa004f7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?S50tSKqmu85+hkYkQ/5lEIxsojKTeBcDarvCV/UL8AjUuiB8kca1+ck70ahK?=
 =?us-ascii?Q?TDlAlsclqmvO3F1dve6m8nHF+9kxW6zpGVcbb94oJXlSS8vqOihJI8cUCx56?=
 =?us-ascii?Q?HnIA9SMm6bCUhKOMMcSt6qPDy57e0O8Bt377l0c8/LWc4nHTIyLzldv75LgJ?=
 =?us-ascii?Q?+In8M1YEj5rVDgmfFT7cJt2C00ea/+ng+AMUj7Tvn875C4jMiRA5/MEeEHFJ?=
 =?us-ascii?Q?qi8hP8ADM4T5XNNB4KPI3agbtkX8pFIxXAJDMT1CVz8utIJfhgmbdN7/WbPF?=
 =?us-ascii?Q?gk/VbwOKo2AnYujs/yX+uZEf/8uAC0z8qzqTvi+GHcXac39kD3MbWPFnZIh4?=
 =?us-ascii?Q?vBTXR64HH/1CoGiTGGRe8+0MfEQEmR2XGDUCHXgHMJtEAr1n0OqQr5VAYW0y?=
 =?us-ascii?Q?NojN/BHbFxP16riVkSIBPFDfSs6KsWHxcnxe8MQD7G4Hvs0aKMog3AqXtxj4?=
 =?us-ascii?Q?Hgn80kzjmzSKCcAmHUfWp7fke7kMAzxT7Y/YLb5nvwsi+HBnHoT6U/fgO+hX?=
 =?us-ascii?Q?fx/7cSSxExzVjBJxFnaGVkRuWpSX0cIxXsLA685W2GsAzutUZ8S8710S0pVP?=
 =?us-ascii?Q?7nKP6shmTTKfLLMAYGqAhXYhIsLJdOYUhjUmXcaMj/mx8nrBR2325+sa1gau?=
 =?us-ascii?Q?+BqgUQGtf8AaIRjlytrY8V3baz/C96xBoNT35ht5xyAYWoNmPFb/YAYG8Ayg?=
 =?us-ascii?Q?FahXAGN6saQQIB+O9ZpMFLh6aTRUdfyFH8U+973SCyhNY+uNnXCtp7GaXCmm?=
 =?us-ascii?Q?YnehexPkedMr9cXOQdOlEOGQnRKAolbl/tfoN3TjNx0qNIieNM1+mAwI5J/d?=
 =?us-ascii?Q?wvlYmo1MmwbWoli7rd0abJDHI9+4ZeyzejBdmutRs95N1gL5Z505Yxh+SRaJ?=
 =?us-ascii?Q?yROJ0/a3nZ4BGpi8R6hhUXePrxm5a6nwKlFOz6BofyoEGZcwdEjgAxhNIAxb?=
 =?us-ascii?Q?vQJDQ4tyBa6KhmuBaSiMYij6wiEBQmEQAaaBv3oxCcDNbA3cJYBZbaQEj0VA?=
 =?us-ascii?Q?R6oC0xpATHYHe/zgPMIcDtD3PIWugzRHWeBynywHwKioCtA0N+/isIGKVBmK?=
 =?us-ascii?Q?g8skwnRxsS2F/xYf93wsvUx+o4WTOn4UD2V8sXRpSLQ7rim/cW0UO+6qkGyq?=
 =?us-ascii?Q?Zcvr68mhUvR24uSyRaZrkDIUv+WTYBEQMC2eZWi0TCSo2KR/O/RoylSYJrJ7?=
 =?us-ascii?Q?Z0OeIDw8LEy02BOHEFo7MfTrmdizaDOBFEGBVV+4wxxHx+NcFQJfx8GdRY/o?=
 =?us-ascii?Q?DqMNDt64+rVcwde8JERBRgo3r5FhNyGDpJ+eyE8jtFkINKnHy2P1WS4hUnEl?=
 =?us-ascii?Q?Z8S76rZxwYZmml4r58ji3b+MHK4zbKGN50rDTK/pOdZvA604YBoKel8Xehze?=
 =?us-ascii?Q?sh0bg5bnw3pCKLyJrepw9XHuuXNk4UrkKrY2j8g7b1w91gzHve2x9anb/6pR?=
 =?us-ascii?Q?fXOFQAyhfbk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4yVPltac9eq+HQlLmI2VQ/WQlNt6rs/fPJEBvLAnyv57D7UlXy5eRZhgkhMu?=
 =?us-ascii?Q?FPQItFCVc1IwW1wnvmUWHLMGmE1khzwpw4F2b5ANIMfbjcKVkPuE9N9zI0OL?=
 =?us-ascii?Q?NMKaPVLPjz+H71/Hcshni/RuNruCsltFeT6TDpfIXinIUZHZea8s2h1PI4pY?=
 =?us-ascii?Q?WjfPtZxTKzBOntXjeTXXMeLnvMEQtJB6Q6NeIdWI++jSogg2VsUZKpWTzkuX?=
 =?us-ascii?Q?citNEXr+FvEtPigeC0bSYz1UQ0YzzgRelzNvQIF2Ro6OnsaOUbhctWNVZr8x?=
 =?us-ascii?Q?PQ/U2Yj1Ouav+DfJHv3U/O/oDRDeSCk5Z06LvgXu25cf8zxGx+itkP9D59DP?=
 =?us-ascii?Q?Ksf5UTwWsE25/+K9vJof5tOMQmmdYX8JyUS/AIk2ep5CJ7a/kqmJshGyGlIY?=
 =?us-ascii?Q?F/QD1iPQODDn1UW8orHl13Ry11R4Nc+o+/PqtiSzFzjMSt6eCEJMlBcGhg9S?=
 =?us-ascii?Q?tUTOGGenNYG0MGq1VKdv+iYyzZ52ncCQR3xB762BMmAE2k62Q/Yb/KeveopE?=
 =?us-ascii?Q?61nFOro2d4qJXAlkRDreXoPvGFNlc6W3ORsz9Edkv3wRd21uYmuj+vrjr1oY?=
 =?us-ascii?Q?LPr7HBvLkMU2pkeL/jA5NntoQXdZRpWiUVuTI2AiqgarEQkKpbxaDB1iE8DH?=
 =?us-ascii?Q?lBArgig4RN392yqiE4vCJ5FhKXYm5i8YjZu+xMIXDM9q5tdJf2BG4A9SBc64?=
 =?us-ascii?Q?dxGLDAS5YNfb4hJ9Va593xKsLWNboAST+QBlDl+vFgwyDAdjE/YIv/VblTM8?=
 =?us-ascii?Q?XhwAqkCjzETUUEcHTwReHJpdwNxj5h/7HzHJugvdq3mxT1DR7Gi3dY72WMHo?=
 =?us-ascii?Q?XoDxN+PoxIv59TxrpBb2+WA4PNu/aO9OQ/eespwwwMG8Z8HMKKgS0vTbiUZ6?=
 =?us-ascii?Q?zeEHtG7CoxHP8m2VINcCphqM1SUL0J5K32YHu+iOn1GggPYpXDHep2jM1+Kd?=
 =?us-ascii?Q?MSqq1fUpNhhw3b6u+/TF/XZzryXHKr7NY8kCC3KZ0hLn5UmvpXw58zxmVj3p?=
 =?us-ascii?Q?bJUd0QgxxM683rHpLGZf89h2YBjLlpSwaayxclmxsXt7HjSEv1g/OW2JV8Rl?=
 =?us-ascii?Q?/ApxzBNmDER8KxRda3lM2rETk561Td11q/91YTBduV8QFxUWGpV5zQibp/ZS?=
 =?us-ascii?Q?j7ngJxL6L+P5bzRAnOnkXO9F+sc/DRZuOqfAzPs9yA4Yia2WDDBx9qeiphy9?=
 =?us-ascii?Q?yUm8hSOFyDzCXNpGXlBuWrQDS60YRvPrqVuG76Gsjp/6bWlV9ZTUUE7WbvN4?=
 =?us-ascii?Q?i6a7faE97XmD3wKIfqM0WefS3k56EWlbGKHjs7GEzqSiPNaLGXD3IMc+rVWy?=
 =?us-ascii?Q?e6AWHPVGPds/Pc/3QxWqknbqHdwzHDVKYBdrznLPySRtLSJC0LvOdmI4hfVx?=
 =?us-ascii?Q?hy0IsaP2Z0dSVuP1iS4r51+SZCJq/apBBW+JDEJri4bkof/wQCKpAkW5dhhU?=
 =?us-ascii?Q?xwlwLZ2ICZc3W862R8Y4+LDqmT4v3dFhsZ8oGN34nY2qBiKzg0MFpLyC3V8L?=
 =?us-ascii?Q?dVnWYjN8JioK84V0KlLTjBTXTH3X+bkA5hAlm94vsL7G6ZoS7aH1P4H0cS//?=
 =?us-ascii?Q?xW6B+hFoDuMRojOEKoysSMLssvSQqiL2flGji3A5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd9d13c9-e9a4-4dc8-7386-08ddfa004f7e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 17:48:59.8338
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d4gRDxD/5jSAlFseAVOeMks7tfKTlgQrwR4tBrE43bXzURyLw/4yfd+kWcDbcmgJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9552

On Mon, Sep 22, 2025 at 05:55:43PM +0200, Danilo Krummrich wrote:
> I fully agree with that, in C there is indeed no value of a revocable type when
> subsystems can guarantee "sane unregistration semantics".

Indeed, I agree with your message. If I look at the ec_cros presented
here, there is no reason for any revocable. In fact it already seems
like an abuse of the idea.

The cros_ec.c spawns a MFD with a platform_device of "cros-ec-chardev"
that is alreay properly lifetime controlled - the platform is already
removed during the remove of the cros_ec.c.

So, there is no need for a revocable that spans two drivers like this!

The bug is that cros_ec_chardev.c doesn't implement itself correctly
and doesn't have a well designed remove() for something that creates a
char dev. This issue should be entirely handled within
cros_ec_chardev.c and not leak out to other files.

1) Using a miscdevice means loosing out on any refcount managed
memory. When using a file you need some per-device memory that lives
for as long as all files are open. So don't use miscdev, the better
pattern is:

struct chardev_data {
	struct device dev;
	struct cdev cdev;

Now you get to have a struct device linked refcount and a free
function. The file can savely hold onto a chardev_data for its
lifetime.

2) Add locking so the file can exist after the driver is removed:

struct chardev_data {
[..]
	struct rw_semaphore sem;
	struct cros_ec_dev *ec_dev;
};

Refcount the chardev_data::dev in the file operations open/release,
refer to it via the private_data.

3) At the start of every fop take the sem and check the ec_dev:

ACQUIRE(rwsem_read, ecdev_sem)(&data->sem);
if (ACQUIRE_ERR(ecdev_sem) || !data->ec_dev)
   return -ENODEV;

4) After unregistering the cdev, but before destroying the device take
the write side of the rwsem and NULL ec_dev.

5) Purge all the devm usage from cros_ec_chardev, the only allocation
is refcounted instead.

Simple. No need for any synchronize_srcu() for such a simple
non-performance oriented driver.

Yes, this can be made better, there is a bit too much boilerplate, but
revocable is not the way for cros_ec.

Jason

