Return-Path: <linux-kselftest+bounces-43446-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE464BEBF54
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Oct 2025 00:56:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9332F401E7F
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Oct 2025 22:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A1E83126C4;
	Fri, 17 Oct 2025 22:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CKdr0BJz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010016.outbound.protection.outlook.com [52.101.56.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5ED4215043;
	Fri, 17 Oct 2025 22:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760741799; cv=fail; b=i8Vi0mSbJDq7eBXAOKCD9HNJpPPUAQW949dWJf2OnB/xNTcw3fuv0DCK4OHLxj12/k8g0CHb1iHz5c9YouAnIL9YSz6y/vCEKomh59MWsx1Pa8W24hjNVeVYmXfuel2pUiiN99l5z7JhEbrQ9dBfYPPXiLJEPkbKacb4R6bQKKY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760741799; c=relaxed/simple;
	bh=Qh2bvLkCZKzFqFKtU4TZx5qvYASbQ041cwTmVYoQSpw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cwdWU6koUTm8GuI461J0Me1a3AFYDzwTywcIaLrO+HpZ/G/dD2GjrB4DjGB/+V/C3EYP4ymPRqRy4MC8kZZZWtURNL+WpXhUSYt3FHu+A/AqFXyMzCTbowtcR5QCRU7jc2nmHfQT3HCLEayIO+sDsM0l/cgfZo9Ca2EUpUdpc/s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CKdr0BJz; arc=fail smtp.client-ip=52.101.56.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UosQgv5GCH5bAjay/6EZVfsiv88bWiznAXW2QRD0CKrNS1NqffZtPk3J4V82Vm9m1pknpnLtnmjtlG/ibLGBHHfp/6lUjH9ROXyS23azidnMwPGDixDBaiDRj2BJ6Uh3FXYxjhKL1VVSVJDMeFj0SHBJBkzmrWKaLnJ1GzGWKw9L8SGFKyUfeEq2SF6d2HTHdBVkXxNkUzBhlTiZzg6nwOMVCR9pwPpEDlLSnGyTJPOot2kyTwRft7FNtwyeB9BumbRVCCYaf/7oNge5g3nYd3J0XQ5+7azI/xEQIcBnndhomdBUyW8JU5Orua7pyoCV5n3B0mt+8pMl8n9iu6idEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rSL/Ew4nR40X/n/KefBF/jLsNJcz1emSmiQLa0Vm73c=;
 b=n13eUQJPtUbFNtNqn+K6NpqFGnbJJQ1hRDpgkzrwmP1A3oshIw3w4ioaCUJGMes5MxyvKe2xPWP2k4EAnXV1geePSY1w6Dphz0wgv7E0pkFcwxH7hFngjOTh7yfOtx7KRwdI15KKWWUSpWxpSHTH4NiMuscOkY9IR6L5NGlohL/FfZdWEGuuxfzY7v69SrThfI+6NAmisjwm5c8HjzWM6ANYRXIrxe4012gxjfA9b16a1pmaQMdrCrOxqjJ/U//21AqdAO8+ySyD+pz65TJ+ioed8lEGagz4GicGvJcGIvcXm/rO5ntv5go8/anvR5VVNQ1j8E1TS3eP1M2KxZdfhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rSL/Ew4nR40X/n/KefBF/jLsNJcz1emSmiQLa0Vm73c=;
 b=CKdr0BJzUTdwPOsw1wI+IkW4YrpuPRQFm1cKyodSsrEfFY6v3oHgNZhhkRGVQkH1bS74Qox6YiUhP+nzGvCA29xw3Be7wJokaAeiV1rhEyOYXPbR3powPX28YWa+yLiuGZW7ULtES0HWnxv3JLEgRaXN4p22czgmkfrG+3NPYzFy74FfvQfpfmXRsgva4Qb9S2FXVVJQLCBktDrauPJnaY9zGxUtTt/PQfrtNrevItHTdseyR4aJ0KI9Oo/5+SD3O9gT6Y0wm99lfKFroSF2FArrxOGdXe3rGp07/gJte6r4lvC1bT5Tau23f22vi4OL33pDabVImWICRsoXsclJuQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by IA0PR12MB8982.namprd12.prod.outlook.com (2603:10b6:208:481::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Fri, 17 Oct
 2025 22:56:35 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9228.010; Fri, 17 Oct 2025
 22:56:35 +0000
Date: Fri, 17 Oct 2025 19:56:32 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Tzung-Bi Shih <tzungbi@kernel.org>, Benson Leung <bleung@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	chrome-platform@lists.linux.dev, linux-kselftest@vger.kernel.org,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v5 5/7] revocable: Add fops replacement
Message-ID: <20251017225632.GF316284@nvidia.com>
References: <20251016054204.1523139-6-tzungbi@kernel.org>
 <20251016123149.GA88213@nvidia.com>
 <aPGryj-V5PQZRtoI@google.com>
 <20251017134916.GK3901471@nvidia.com>
 <aPJp3hP44n96Rug9@tzungbi-laptop>
 <009c8e5e-02d3-4017-bb84-e3a8f01b9dc9@kernel.org>
 <20251017163738.GB316284@nvidia.com>
 <bee969ed-c050-43a4-961c-07443a45943c@kernel.org>
 <20251017184415.GE316284@nvidia.com>
 <DDKXACTUJ9IT.3W11J2HE7SLJW@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DDKXACTUJ9IT.3W11J2HE7SLJW@kernel.org>
X-ClientProxiedBy: SN1PR12CA0092.namprd12.prod.outlook.com
 (2603:10b6:802:21::27) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|IA0PR12MB8982:EE_
X-MS-Office365-Filtering-Correlation-Id: acf5c828-0d4a-4b37-ea03-08de0dd06b85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?N30U2M/sLa/uu0xz7/tjY2vriKOQHpu4FGED1tqdn5TyhbY3WOfvJFHx5+K/?=
 =?us-ascii?Q?66RUz06D5q2+ExgywSuDaWJtiw1e7tr/K2BisMssGQlBV1YcKRF2pseA/9CY?=
 =?us-ascii?Q?xaxXhTR4GyiKVcOzpXTxD44DQElXcd6oFLNUhvelMbV878hV4tW7I+ZzTUhT?=
 =?us-ascii?Q?uyz+by+VxGcWgS7AORb7OCuGDLKl9PN/LTWD2O8NH6Vr+eNWq4UliY4ClcQx?=
 =?us-ascii?Q?I2bVVVjkKVHZ3lrPyCWE6/rw/VMfXszTwGdOOnW4BZZ/QxV+X2mIbqxZIfIg?=
 =?us-ascii?Q?Ovow61LUfcmWDqzuAkmD7g6ETxyr61xItVJk4dv6CuM+NvTPzjSieFhDICHm?=
 =?us-ascii?Q?Vg7+ywNGuGS52q+17Z6RdiKSuDuc/9meNOFWtbzNYncrT1AWdlP42vqR2XIk?=
 =?us-ascii?Q?cfoJLhlH7px4Y0ebttNYnq0W8VDTqnC+OMF8U1o3ptlTJJcMwJf2z8rw9/Su?=
 =?us-ascii?Q?XnnWbqjQ/zlagq2eRGNJjt+Il0F+BE0OJhsUEwyEKI1eoZc7AuC1929An+yx?=
 =?us-ascii?Q?lzzbQqelxd+GeHUoYjgs3XZrxBJITX86/EnT4IdObBpJvgdh4jg23GZRF++M?=
 =?us-ascii?Q?ZfoooL7jG6y1AD7Gca9cZvtAIXNeMiLkSFmp6/VpuPyxBaVLGfC2Iph4+J8P?=
 =?us-ascii?Q?u4H7F9Nj/G40STT21p9CXaEI9DuZYqt1aQWhYwKrceBD9Wf6VQl3L6ZFKRta?=
 =?us-ascii?Q?FCdGVf5Vseh4JtEiboguyMVNZllOWcgsA1mZZRc/crdZV+8IpPiY5tOozQHj?=
 =?us-ascii?Q?Hw2XvNaaBK+k0/F1oozEGYx5hV/tez4mHoIAfK9Wpi+97pQhISyhVwMkIHr7?=
 =?us-ascii?Q?wKr/qtb9UhngZnXB2cOLr7M6v99kHysX3ZWwndj4iWFOBDXNHl/6M7eoP24M?=
 =?us-ascii?Q?cX5lUl/+KWL1+bcQj9WbfNjrSPBcmSNVav7vzeD1hfbqkA5D2mS7EflYBdMj?=
 =?us-ascii?Q?IdTs8s2+Jq9oGbwo81TI85TNHxZPmq8EMLy9J8U8ntMVl4J5iHsLkrjESMWw?=
 =?us-ascii?Q?z60HM9hGUQ0Gwt4SNNm9Y4wBl7j7iI9NVCITPKB+h2NaeVzwRlsk67KB4aop?=
 =?us-ascii?Q?GtEQ2IPYkh/5Yyl80WHdTTtHBQ1G+k8h0192deK7BzYq7ZJUrk7TWK3P9pIm?=
 =?us-ascii?Q?N7ghz6tREE8+mNwgtcIysnKMX9u2Ia4ow4r9y63UJl+qfI9aeu9c0IeN9pK0?=
 =?us-ascii?Q?UKWwYQ+zOqdWmt06zglQT5nVowz54LD5eMVbKneS5ImBRVVM4RZ42Z9wnjXy?=
 =?us-ascii?Q?S0gTMii6X/GpsMOr5YLGdHnxX0rhp7ZD8dmZRzRyN1j4kJX08O2KExRvhHU4?=
 =?us-ascii?Q?CdS865HuTky7FTbrdaWp0RrkF3Q/B4MVsm7muzn68z0dRnX5palOwupjJDK/?=
 =?us-ascii?Q?q5x6Ohg3BDbBvCF3CQcflerxnraeYe4yupOUkWZ7lSCYIdlSfkb8LaDIzQbX?=
 =?us-ascii?Q?NhRFLkkVBbdY8ysVFXR1XpjaNRErQqaH?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?P3+pV8h2OIu2y3TEU8OkC2IOwI24RAkVOrVPSxyDsX/V6l38pHDo+BL34kGj?=
 =?us-ascii?Q?XqXLSYJ4aZiuFFitCNGPbVBV9IrwIGDKse2KcD2KMzjA1eIe6KUb+j8B2Ik5?=
 =?us-ascii?Q?WQEIU+XJPerpzScmdYvn5J9nREmKnpzkNUSlAjQRjjK2ep/vI7jo9oVTZpZ5?=
 =?us-ascii?Q?TWaoIyA0uDxl8sfTdqGrLKljoO3KisxgGc7D7phVRS5U/kfb4WDYIyvAvS6K?=
 =?us-ascii?Q?E0rePJXSj4MKU1txwDi8UjzxmtO+dsDGyHGsA2KgNDWOE75jt8gNwoyzsy9E?=
 =?us-ascii?Q?QAz9opT90BeRrTVgYNDzD+KgwfgsRixVF0AAivjgXyv+tczzcspeBiY2RRUD?=
 =?us-ascii?Q?beNHI1wbkez9bbQ0Gf5ccsszfCkyS/AJz/9koRMFAnTFOycxpymtKEbaLOy3?=
 =?us-ascii?Q?X8ww2Gvs2proXNro74R2flyJ3xnPybBHQKGXTQUVtZrNFBx/IhbG+cgTXPYe?=
 =?us-ascii?Q?89L2yEfD6PICCz1UXeJ8Rb3690T0XrZvCRnM0Xo9LTH9FseYj5+ZScJcmvy8?=
 =?us-ascii?Q?O/fRkp/+zQO2GOc8b6JH962EQNoP5hhKLDwr7tHfZ1ouEe82U4oalc65bnH0?=
 =?us-ascii?Q?2eEiILO4r+dXuTILtre50Eukwr2N6xpn0bIiNhOcBDeWhuZuEHjauzUJS5nY?=
 =?us-ascii?Q?GgxBFZoDpqldeVdzQN5G1THcSSbBvqm7S5tuY5nqfmqTVIz1lTgioTtotXp4?=
 =?us-ascii?Q?R1GpgxWgbzlLyGr/LiMbhg38uaSYYLPoJO8Tf1uVgBuHb3BlG5cxVZw7xG4i?=
 =?us-ascii?Q?K444BYyWteplXVIiFZ0qN3uT5uLxoTa/6LuTg6yqXjyJ/V8Pzo46sp8oXoRU?=
 =?us-ascii?Q?cHEtjckuCFpOZkvodoDweDhOvTKtmbkkqsh4hkeQQyKqKwbvz0/qyekThrKl?=
 =?us-ascii?Q?RL6jWxmyNZOSQzOxSJUilZNXspf+A1lpjJj1EP/tjCzjDTHeEGB6VWckuuIc?=
 =?us-ascii?Q?kDbewFCADxpgkyzjY5pNsko/jgRgark5ZAlIYqJAeOAg2cDPAsUzuZ3UtYvn?=
 =?us-ascii?Q?j40CuP4A2iz6JW/NVyZfn6zOHSDlXNJKE109+GKgpyHsQGOhEOQ58Fy+EKiD?=
 =?us-ascii?Q?+lC5enOeIL3NtxeSZYoU0eGxFlyya+zE/hdSTXP9zu06KW4un5hKllG1wWns?=
 =?us-ascii?Q?wIBZtWNs4CpgtcnasGr85yFNeSkz6rfRTZqt+ZWlV74yz97RT6ChM6WdwcsD?=
 =?us-ascii?Q?M8c86sDShkxUlmGjhXftuNvEA7Xb4yrYvUUEM1AO0ujr0cCbTwAn5idsrj11?=
 =?us-ascii?Q?OaEhw6TmLlVTojuhUxlpuUVolVlnY0P0f1ADQbXDynIXG2SA+GwEvi3BKmk1?=
 =?us-ascii?Q?/dhtbAvAE+CepIoDsrlRJhzLudrrMDo1dAGSeqk7sy01QYwSibBZI8TlveU0?=
 =?us-ascii?Q?PeSHxUXuOlsRfj+AR22QjsAnUpVm5rTK1tj2bKA1QRV1VqvTaSHgYMD2qcs/?=
 =?us-ascii?Q?FfWalaYJ/QL7EplgXQjsthy0QqILeY/sGlVm6/Wx5IT+y7Hhu3AFH8aM/o1U?=
 =?us-ascii?Q?BQSHXMuWrb/3+DIY8N5VZHBUTuy/qh6qpGKi9iS4pV8uvPjNgXHmNLF0jre/?=
 =?us-ascii?Q?thJv5AqHhwCwLFiOhRR0IJfOpa0YrUeEDAuQo4Sa?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acf5c828-0d4a-4b37-ea03-08de0dd06b85
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 22:56:35.0972
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pQvJX94e6yomoVZTQb5vh6Um1eZn2T76gk4jjmCUACa/WuLAvNSx8ZQbayspPIBJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8982

On Fri, Oct 17, 2025 at 11:41:56PM +0200, Danilo Krummrich wrote:
> On Fri Oct 17, 2025 at 8:44 PM CEST, Jason Gunthorpe wrote:
> > On Fri, Oct 17, 2025 at 08:19:06PM +0200, Danilo Krummrich wrote:
> >> On 10/17/25 6:37 PM, Jason Gunthorpe wrote:
> >> > On Fri, Oct 17, 2025 at 06:29:10PM +0200, Danilo Krummrich wrote:
> >> > 
> >> >> I'm not sure about MISC device though. Unless there's a good reason,
> >> >> I think MISC device should be "fenced" instead.
> >> > 
> >> > misc is a very small wrapper around raw fops, and raw fops are
> >> > optimized for performance. Adding locking that many important things
> >> > like normal files don't need to all fops would not be agreed.
> >> > 
> >> > The sketch in this series where we have a core helper to provide a
> >> > shim fops that adds on the lock is smart and I think could be an
> >> > agreeable way to make a synchronous misc and cdev unregister for
> >> > everyone to trivially use.
> >> 
> >> Sure, for MISC devices without a parent for instance there are no device
> >> resources to access anyways.
> >
> > There are many situations with misc that can get people into trouble without
> > parent:
> >
> >  misc_deregister(x);
> >  timer_shutdown_sync(y);
> >  kfree(z);
> >
> > For example. It is is buggy if the fops touch y or z.
> >
> > This is why a _sync version is such a nice clean idea because with 5
> > letters the above can just be fixed.
> >
> > Wrapping everything in a revocable would be a huge PITA.
> 
> That's a bit of a different problem though. Revocable clearly isn't the
> solution. _sync() works, but doesn't account for the actual problem, which is
> that the file private has at least shared ownership of y and z.
> 
> So, it's more of an ownership / lifetime problem. The file private data should
> either own y and z entirely or a corresponding reference count that is dropped
> in fops release().

I think both versions are popular in the kernel.. You can legimately
treat y and z the same as device resources without creating a
correctness problem and it is less code.

You can also do refcounts.

For instance at least in C you'd never argue that people should use
refcount private data when they use a timer or irq subsystem. You'd
use a simple sync cleanup and be done with it.

These bugs are coming because of mixing models, we have a bunch of
sync APIs in the kernel that are easy to use and then you get these
weird non-sync ones without any clear documentation :)

Jason

