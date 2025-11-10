Return-Path: <linux-kselftest+bounces-45226-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DC71EC46F63
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Nov 2025 14:40:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9AAF04E7536
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Nov 2025 13:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65D57311C2F;
	Mon, 10 Nov 2025 13:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="E06S4XjA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021131.outbound.protection.outlook.com [52.101.95.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D61519F41C;
	Mon, 10 Nov 2025 13:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762781940; cv=fail; b=oaJEYe35kMPcDDPCIjfcBAtavrb7xqW2hi1pWpuY+5puIET3qCNDYkwsLl9RAe8pgh/FHdrXHYoCcQtQ+LeHfCCKxLBpq4WzZbsb2VXSHuQxPXGjNth4uX1K/nVY1mItyCdsWBa/Jtq5nHK/53O9b0uZ83NHWmamZJek5ppqeaA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762781940; c=relaxed/simple;
	bh=lTVo1BcuOTmN1khtmmKHCJfHDkWkc6WutBJXunRsPwc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Fv1Hk/RaqOpW733lNyO5fmUpTl9J2Pz0irN52obsFjs/wmd0uibfTfsze+lNfhUqDpgHsWAX8M/IX62DpVHk5JxR9SsEkVdUKd+uVjJTCBLbEgkzWbCfDFk8Us4ZJ6jJ6nFOaekrnvHXj7cTMYMlMX/GHSV6UVBCkPymha5qfcQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=E06S4XjA; arc=fail smtp.client-ip=52.101.95.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wU3f7PoOR/jJIBgaloS+MV2x5IJtX3+nVHCCmOwx0cuZqfReWzvb3u9scRf7nCieMy+TO1TJNzV6g+qaAHjD85WG5ISJ9scvyHoytnsSI78U7iz/zT2JpQ3oJOi4YUgocbj2nHsEbEGBzJjILoCBIEVQAlvlhPT2qlW/uRxTfcguujU9PqMfIfItVw8k8eD5QGc5ND+Q0XHMRyi2sGt6bGtf0RJLfvzqHbyf+w9grV3J555ncYRroP/QNxeWWqh2bJ8nO24n7BwoSJl3kVi+PtzK1IiBZlLMfsABJqtViCxkUOVzrPcSIjCFjd9cQnecKh+zlZ8wcX9MHEnxlIK3Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QCB7TJTf5H3GPn0o/AB6QImwZXHU4tY2fiHQeI2UGNI=;
 b=HU7+uNZpBg9T0FLvrKzrabprB0YoTJz/tgtUCpJ/6DhtfvIvBwNanRG1jdHyDxNbGX8cFIKPL8UtvndPqBRiBszTfW8jQoYAGboZ9fBFIDNt+VUMWluFtfj3cBZLovc0leD9hF/KeWzQwUgRL+clsiGIWLipb8uNF5W1KW5p426Fl3eXuMsmbQzElDWi8cLc+KEhCesASNMfjsIEIRRpX2x/XZbqHTWDrXKxD4rmQe0bjzbMRGagHXF4h73SGHhk58B2j2vTds/EMYB7VrDzs2HA1RHiAhryYO4u4bnuuQEAMt6JMAcoIxEMaUj+79HaSFyWUAk8ZnG8Ja6MpsSRaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QCB7TJTf5H3GPn0o/AB6QImwZXHU4tY2fiHQeI2UGNI=;
 b=E06S4XjATR9tdYg5pvdJdcsNTsz8bCsd6Vc/Gxge0S3LuwPlxJhaJ7URB3xgrAWTyQhzBIz5zB2lBK0Jp03eTVkEP5P+k4URoiNLnKCXQEF6RxgzsR41MkWeaRgiYCE18hRepcJeR0y6gRJUneNvlOPGTzRuDznWLi43bdRkP6w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO4P265MB6445.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2e1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 13:38:55 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%6]) with mapi id 15.20.9298.015; Mon, 10 Nov 2025
 13:38:55 +0000
Date: Mon, 10 Nov 2025 13:38:43 +0000
From: Gary Guo <gary@garyguo.net>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>, Brendan Higgins
 <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, Alex Gaynor
 <alex.gaynor@gmail.com>, Rae Moar <raemoar63@gmail.com>,
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, Boqun Feng
 <boqun.feng@gmail.com>, "=?UTF-8?B?QmrDtnJu?= Roy Baron"
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Andreas
 Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 patches@lists.linux.dev
Subject: Re: [PATCH 1/2] rust: allow `unreachable_pub` for doctests
Message-ID: <20251110133843.37ff0749@eugeo>
In-Reply-To: <aRHSLChi5HYXW4-9@google.com>
References: <20251110113528.1658238-1-ojeda@kernel.org>
	<aRHSLChi5HYXW4-9@google.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DX0P273CA0101.AREP273.PROD.OUTLOOK.COM
 (2603:1086:300:5c::6) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO4P265MB6445:EE_
X-MS-Office365-Filtering-Correlation-Id: 971230bb-e227-4b9d-d5ce-08de205e7e27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2ITmgGAckOHf5H5Sf3fqZqxkB7gDl+/u5S2zc6M52Ak1OmTLomFTE27ec3sK?=
 =?us-ascii?Q?y6ryW5tSb2msP9jmUkmf0sNm3QALDyl7KHDk0cBtzGaaShnM0RRczYsXMa1W?=
 =?us-ascii?Q?RYeQa4W6ncleqk8cDGbmxamqalmLH53kaZjn/1aqK7JqrP1CGO+GofkYKtXm?=
 =?us-ascii?Q?/vJFh/K+8OnkjglsRHCP9SdANVL/YQpt24tmQwNUMvfTLu1rafpiLLr70wY9?=
 =?us-ascii?Q?6Sk+pa+Qng2W2AY4xgTx91jWMiCG4joCOrZ6FLg5w2k+njpIl/f+jkeT95dm?=
 =?us-ascii?Q?mrrtkvl+HGkog+L8IEFt8HUPeYibulzrDINDep5n3uhkojto6AG9eyY9WnYu?=
 =?us-ascii?Q?R6VLjAogkAaVaic1lmiwcVFVqLEhRjlSQGOJXkYPQNwSDwKHaWM6aAIBGjHt?=
 =?us-ascii?Q?p0oGzftyB+sUCCTLFnw8zHNsVN0HRSaL8sysW55mUS0WmxdwlXpoL3xV7gCH?=
 =?us-ascii?Q?/Umu8dmQEGkmEFjyPSu1Mk8ol9JjZtMdE1pYZeIEFomIdJHRmb+uEdzPUOxG?=
 =?us-ascii?Q?p0yWGielocrbebIPGkNak++y17nAranydTRO6ts6I6NBl8vsfHyD3Z1berrY?=
 =?us-ascii?Q?S6WdiYMskhpmHyXg7+jGu3tZ2iifcOZF5Wuh5JuqGOVghuTiez3v+LSgtlMI?=
 =?us-ascii?Q?uqSPjS6yDh7f82G9nDfL9RSvioG8WerXe7LSIdulL7YQpd2scVrsbvWTrlOR?=
 =?us-ascii?Q?rL6atESnNWIqrQWBC3i3JpOm3LOjGFx5sx/xZpYa7k5QxwB0qIT3y2oUVKjk?=
 =?us-ascii?Q?AFkoNTOF8uZO2KrcfDa70JzdUG9K8Tn5zLxLZQTnK21nwc1+jwtB6VQBFTLa?=
 =?us-ascii?Q?JtMCirCn6letFK/wpQDJ5hdPZZMUy30QC6r6vQRV3+HKvVl1WXec/nkOxrrP?=
 =?us-ascii?Q?Ik/J/vPb8E1cNG8sFMtDhyUYqtM7vrF7Med1Ja4yqxpTHDGZcCZ72kxf2bre?=
 =?us-ascii?Q?CcJBmP1ddXExlH1mRWxix4mBgnRZLGjRCLSjCcI1BZmb0bkHa9G2RPQN4Xnt?=
 =?us-ascii?Q?2jqDpvceyonFT2sjFW0Ec4iLKR1K6XnLGOA14RYxr3CJ7VcYbB+0BMprTYoH?=
 =?us-ascii?Q?SHu7K2osJKSkX/r0j7QIaBAD7oI9WHKaHiqYGKzGMQJJoIccdodLD2sF7KF+?=
 =?us-ascii?Q?OpNoj/s2NEc7nW+0v4oeECxhp3vbEYwXdpwS5uwT0upRl3z0zLTB2/ffm//b?=
 =?us-ascii?Q?T3QfeIiocK9+5hmHZEkkc17ZnZN1Jk+jbtPLL4TBSfiHL8pZDrpPIYUQDASr?=
 =?us-ascii?Q?EVGvBbgMlS5WNK2x6l/J593JgPfNpvojba05XY5BXuPr5R/5yfHQDZ7jrvsa?=
 =?us-ascii?Q?Xlnlx+g4lUyzX/L7TK0KNNJUrwkFLO6hKBsyVhSSFloBceiRfK61tq8KxV4c?=
 =?us-ascii?Q?86k66dMHBBbZrz4TyWO4uNND6Lri8VYiB98DQ1WfS/s8n3HH/rnUGufM3NIM?=
 =?us-ascii?Q?JroTBrHnWE6IwHtcwvfZXK+xzES93mRj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FlM1AeTPMhuygbhvQLpg7Uz2uGpMADbFehPRewo2q01yL/R8+YEGCLpr7GC6?=
 =?us-ascii?Q?bpPZgrInqsIJrzUzK5IfSmVlAB18QFme4Kl+rNJOj/TdA5+ppwx3KGctLuM2?=
 =?us-ascii?Q?yOWZe35lgb+HKpAe7bTdN+WJC7ZCp1c+1/6uyv/zhqrm3rUBOt+u9ngR7HqD?=
 =?us-ascii?Q?y06I5QNOlUnAIUgZdiHcU4tYX28IQb78NAUfZgbG7V76C+3KfAcV727ujgbR?=
 =?us-ascii?Q?FCuXctetFqh6xYM3dp1hvitA15q28BpZpWcSWhpkm7NNEb8juUA9sSPAcbG0?=
 =?us-ascii?Q?nyoYW0KSgkFX5wEyTWL272LWcl0gV1jNltdib6M2C9n2HjzUigKZ7aaQfpde?=
 =?us-ascii?Q?nw/kXsfbNkQlmHx25Y64Ok/xNc6DBEQyfQEH1mwgZMFqCl2VtiThJj+kmsgS?=
 =?us-ascii?Q?Enep5FTaOxH7JPsMkQdEmKBCOPMcpAv8Tj0CgfpUsKsMCNxvX6f4Ctw9K5dO?=
 =?us-ascii?Q?FvqIniigVi6b0TGSiF39S9NshTkZvt0dD9SYVJPtz8iFw7njouNB5NQYV6ge?=
 =?us-ascii?Q?dCo3uHenIPSTj5JazWkICQLfHms0bKRMj7lnhJBDkJ3Wd50LRk3dd4o4gHCl?=
 =?us-ascii?Q?lKE587t4ZwIwO9+ZcrVqaYPO6X7HWQ++ie3a1D88R4KNYeUR9YnPUsdYFKvL?=
 =?us-ascii?Q?+Sdr9gxl4VpQJA3ElB7051QBEVK3eJCGnN3Ac82W+SaYRfPt+bVr8vNvhvI5?=
 =?us-ascii?Q?uajUl/HgUtHFSX3rOA/qUYGwSn0H6f/fYsuB1T42ykNJqLbfGVOU2/f8R4DQ?=
 =?us-ascii?Q?7KBmWxEsWGTPIvZGC0tDq8TdEZr6iL0nW/hwTutddK6uGbewHUvE9R0dx0HB?=
 =?us-ascii?Q?G8Ll6942ApJMShQkEpi0XXIKkgGpBh6Jfsb1lHHomfcWBCouns9qNT+WB0wC?=
 =?us-ascii?Q?InN42ghttbL4Vbm3oc3/dmoN6vFS5SmcU+riTNknAn4/N7McIlpnviOzmZaU?=
 =?us-ascii?Q?aygMrpldxeHNcBwhh8MhfvnqvL6c9Qa0pCbY6hMymBF7rRUY/nj5I3AKKwBz?=
 =?us-ascii?Q?WNxqtqU1DKs+KmgWyzSN/ZCi+x6vEjP+MNgOSVkwEV2un4ECBqydMTVK0uQQ?=
 =?us-ascii?Q?iw3mK2Lwvw0i47X6YgIT18v/qgH7BdCIXFUyU/vfIJOGhEj3BlAUYqkCJdQS?=
 =?us-ascii?Q?TLbyx285mxNFWAXpaH/U5iCsysnkQxNY0fqsyJXskJyOLeVYRQ4hfGdlzOe7?=
 =?us-ascii?Q?S4c3E8G2r2E5ZfHIBXrmczmJqhEEwBaSaci0rTO9o0DzqsqpO4T80PC36aXz?=
 =?us-ascii?Q?XRYuPsMU+UmeHVsrhZdBEggU4OBKMfIK7QyP9t2SaZ99mnFbUHobEaD7mi3B?=
 =?us-ascii?Q?G0CHEFY4XgRPiJAl4+Gjm9Hu9Iz/wI4iktJnV45YkIeWzsN0/DSip2ciU+4t?=
 =?us-ascii?Q?seOPEaaVKxp/JLr0El0LuW792FPQbZ9y5HLR+6nkDfND8lEfUE7VBp6SqQ6K?=
 =?us-ascii?Q?a+fqNW0KmD/dAjHFv0UKZ3va6p3i3X2jp9r0hPMFIBRQmkyrw1DLLoPDtGh6?=
 =?us-ascii?Q?eMSlMUHFFz/zhbc7XBjHTirp19x1AOtRpojc8HP75hOpukYyfcbORE3MBarZ?=
 =?us-ascii?Q?LZdbkBvYxvu/jo1+l0doTI+H6qAVFXrrShUaupLIPByASudoFR1CLw1fgdB7?=
 =?us-ascii?Q?57SyyGkNGGBO6FJVsCLSMbZTgvKWkc4GEAP2svmJw/H/?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 971230bb-e227-4b9d-d5ce-08de205e7e27
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 13:38:55.1178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /nRqTRvAb+93G71IJD24YsaxH6hGqkL8/DK/0RAqUwFTVSzNKHxtpiPtJNeL9UIvrYwz3lZbEyE1vEyO97a3sQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P265MB6445

On Mon, 10 Nov 2025 11:53:16 +0000
Alice Ryhl <aliceryhl@google.com> wrote:

> On Mon, Nov 10, 2025 at 12:35:27PM +0100, Miguel Ojeda wrote:
> > Examples (i.e. doctests) may want to show public items such as structs,
> > thus the `unreachable_pub` warning is not very helpful.
> > 
> > Thus allow it for all doctests.
> > 
> > In addition, remove it from the existing `expect`s we have in a couple
> > doctests.
> > 
> > Suggested-by: Alice Ryhl <aliceryhl@google.com>
> > Link: https://lore.kernel.org/rust-for-linux/aRG9VjsaCjsvAwUn@google.com/
> > Signed-off-by: Miguel Ojeda <ojeda@kernel.org>  
> 
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> 
> >  rust/kernel/init.rs         | 2 +-
> >  rust/kernel/types.rs        | 2 +-
> >  scripts/rustdoc_test_gen.rs | 1 +
> >  3 files changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/rust/kernel/init.rs b/rust/kernel/init.rs
> > index 4949047af8d7..e476d81c1a27 100644
> > --- a/rust/kernel/init.rs
> > +++ b/rust/kernel/init.rs
> > @@ -67,7 +67,7 @@
> >  //! ```
> >  //!
> >  //! ```rust
> > -//! # #![expect(unreachable_pub, clippy::disallowed_names)]
> > +//! # #![expect(clippy::disallowed_names)]  
> 
> Maybe we should also allow disallowed_names in doc tests?
> 
> Alice

+1 on allowing disallowed_names. I think for doc tests we should try
to reduce false positives to make it easier to write them. We shouldn't
try to enable all clippy lints on doc tests, especially that clippy
doesn't run today on rustdocs at all.

Best,
Gary

