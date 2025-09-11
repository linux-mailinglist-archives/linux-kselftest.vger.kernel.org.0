Return-Path: <linux-kselftest+bounces-41246-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 975A7B532FD
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Sep 2025 15:00:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97C917B085C
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Sep 2025 12:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 665D9324B32;
	Thu, 11 Sep 2025 13:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fydAjHaj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E3A324B16;
	Thu, 11 Sep 2025 13:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757595615; cv=fail; b=FElRUs9LRQotfnQIAd9eETQuuJ0y9SO2FZJ6rQ0K1P78SLrzlPDGHg7ePpZVQsZrUE0xjLUGOFtdtnabkqH0M/XBq2pjgPkkax1v2yn2HCPfBDbfGWIZjJcRbVvbXgT7tCgaudeQh5kR2tQxKoVlcnHsntpVgDyFWQnDZ7pkPrU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757595615; c=relaxed/simple;
	bh=VsiWVTJW+KYm4JhcPgycSmG1d/ACWWu32Tnm4kZrhvw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ByjeU/ATOctuUqiDvIS3dKU4/lBQmW251ZDg2QZi/IWIbDXh7oxoQC0uwOvUjEo9XA7PtmLsfR3msRhy2vE+w0c9W9BzH5s03kCHB+ENnsg0DmcLUYK98KwMCCz9t8mKVKNAdp9NqQO7yCyDAuCfoTnFxyGLlWSnklCrErc15s4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fydAjHaj; arc=fail smtp.client-ip=40.107.92.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cq4VM8ueG6PTpzhf+Nsjpusp/gTzkNYYCxWV7V28VmWO3YG6KfQRZOzZtWJkEJgw7UAJwu/8GmpukTx0PtpI5t5l7n3ZSevC0iZVdNmZSzzJOxYlHQvNi6eVzBHGtAnnx/8cqK6qFgzv0wMJzA3+ezYgaRtADdCkjWdWFJ+M3NZEb+YUXpfrGDpudnkFrRGFLNUH/jtrkD4TOWZIyaM0HeHR9pUzNcKUv+kpVpY8aQyrMVm+NxoTJBH1gJuRaewuVMN65/HGHIaGCx+pztIMuI3Q5pGAk5tQgbctypni8jePEJuPYItTFFkLE2I716uxpEjNXd+p3K98GNR42Bfb4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YnsTrojJqhXlq6lcXmyv3rgfgTAI/QTYklAQb8wrMAU=;
 b=bnVlYma+eimtCHUSgHsS5FCaeN2goq8JySXlUqdNL/rW/7BvvNfM5SBChi3Ax9foqYhFtAzy4N7udqw+58Lyixiu4yD4JJlcKhBNEy/8JAm/WklE/MO7udyzR+dCyImH22cUFtkKCb0E+/VL0GBcvKGml9SLRZg+Zw0wd4p/4bfcJb24PXW6sfkT0QA6EttMdtqArYdYFimJ0USNHXoknJ0b8C+qWszoOix7f47PmryMdU3JFHswHGf5AtPMTeI2/xTJSqXI06yYRlQVxhzEdpikn2sVA5cgpwYne6Cu2La094iJOwa/x0nP1+ZyKaprksezCFItp5kFA57F2wRmew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YnsTrojJqhXlq6lcXmyv3rgfgTAI/QTYklAQb8wrMAU=;
 b=fydAjHajz3tD1I49gQHGI2Z5E7IYhLx5NdC3ktrcuM0ijOg954SQCYa3StqAp69DK0mpA1ZHDmsSin8u/j/OQa8LQAyFEEuHajRmmu5cM4lx84NvKdQJnbbbmpcLEP1feteHDLlXzcgq1rRyyFRB7H7FVL0fHVPO38vi4i+cUCOszS03P+lgw4k8ZZ4d8EgXOI3zxUXSLtFaIq4/Lm35mAOJb4hddMX2geM7NAyHdRPa7oXGkLiE1io2mQAyorhIkP6xqFwv2/a4s7Cl3pV6Hjz+sYVwz7O56wFbKTRRAsE4bF0UoKjFhuQlnQefaeQufTFXo72C89wbmk+zxZWfLw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by PH8PR12MB6675.namprd12.prod.outlook.com (2603:10b6:510:1c2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 13:00:08 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%7]) with mapi id 15.20.9094.021; Thu, 11 Sep 2025
 13:00:08 +0000
Date: Thu, 11 Sep 2025 15:59:59 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org,
	Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>, Simon Horman <horms@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Shuah Khan <shuah@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	bridge@lists.linux.dev, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 1/5] net: add a common function to compute
 features from lowers devices
Message-ID: <aMLHz0P4KhHPNIcc@shredder>
References: <20250829095430.443891-1-liuhangbin@gmail.com>
 <20250829095430.443891-2-liuhangbin@gmail.com>
 <aLRr1W3jKRDYsRSq@shredder>
 <aMGLTzACsKLRIsVb@krikkit>
 <aMGwcyKTvmz5StN1@shredder>
 <aMG4W9xUGxjLAVys@krikkit>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMG4W9xUGxjLAVys@krikkit>
X-ClientProxiedBy: TL2P290CA0022.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:3::6)
 To SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|PH8PR12MB6675:EE_
X-MS-Office365-Filtering-Correlation-Id: e7ff26c9-1588-49f7-1d23-08ddf13322b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aXvGaU5WMPdeCvblXu48ui38uEoK1PLIeGpX0oopp3O64YE9+YyaZcf3Bptv?=
 =?us-ascii?Q?mJDDMYXF2bBmCEQ7U8X2lC/WJ5Mui6cncsv44zy4gCd/ywAQ6NE0b4vO7ddL?=
 =?us-ascii?Q?6YSgElfpANQrUg/x232rSW7fyja1Oe+tGvL92Sea4BW5WMtJvdvyUG2Fn5/A?=
 =?us-ascii?Q?y3Mp4YLBu+PuJp69efLxumph8APfy4GCkJnudjlNQ/iYUKL2nC2Cyjm4Uc6A?=
 =?us-ascii?Q?SKKIYdOq58LbsZM3BRDb9O8agjpj9vs+sY2YepsrBhWNSKTMisX74DfdiqSM?=
 =?us-ascii?Q?pICmcnkD2UxzTMtlHg7543jPebTr9t0EZ9I40YJqttU2O7AAjuMfzzuDgjq0?=
 =?us-ascii?Q?Hhbz20/orbg4ZJubQe/myudALffi2GbCIdHKq63R68lpSkZjUmt/IrmO0217?=
 =?us-ascii?Q?4L9vgfz9838Qzx8fXntDSmm8uK92sPmKc5K+fSPXwpMnGfpmQO4zyIpwPW07?=
 =?us-ascii?Q?LVqHwSLYPtwv0fYUY1erD2mYBtCq1A8dbVBQ8/+JDZzzmYviRPN47GvfK4KV?=
 =?us-ascii?Q?/2GC7Dyk74Sp3FJpxo8C9rVN0T+/DS8Y8o2ZdyviMN71pgg3cGbKrHn7PvQK?=
 =?us-ascii?Q?1j8T+R088gcTTKJSteKumv3VWccvVzNzmW+idIUyv8xEYCY3nPHvs8uwLPTN?=
 =?us-ascii?Q?GXVHyhze5VMUUGNwGMC0zChoDJacINJ23vrL4fMpuvEAMCIhhDuQTjyqVgsO?=
 =?us-ascii?Q?RTInXcb0bHKVVXm/vIKDm3JlDCPjeMrCzCxZHLbjeuzm8+0ZtPu11sfZkBb/?=
 =?us-ascii?Q?jrI950J8Wmb68RYy8o/2uEu5leC5Lspfhea0IO9qUV54Vj1xtj1IgQEoLd+S?=
 =?us-ascii?Q?Yz5f/kuHWwf5iM33SuRiiRsAPKK2nlG/Lz+6XExae/SXgLdaPDxtWEMgMSlb?=
 =?us-ascii?Q?ICmCmLkQ7itYf1kg/BQPBEuIJY+s6xj8f88k8fro/1SwbsT6I0hYgMfgeF7m?=
 =?us-ascii?Q?KVCmUOHpg+EBp4oP0OTmB1050qnxOY6nJYIoibFT4yKcBGDJiQ3h+7ptD4O5?=
 =?us-ascii?Q?J+Z6vYdshb5BhPsARYzdDpRIurol6Rb23udH5VkBCZvVlsipIDBJqPfrPz+h?=
 =?us-ascii?Q?TmgTYZc8hjp/f7QV4qZnSYRvjh5KFmOn6w+RUBxfKv9RDVWYrWxk5XsncCbs?=
 =?us-ascii?Q?kYwGkN+NQH08OqdVdY6U1BomQJKhGM2uwYqYC3vgiu+aa13lY61LUtoXOnrP?=
 =?us-ascii?Q?WEPoICCg9UHb1tVjy6HhHs9qjZWMnkWiofmWA+BtDnwCMw0Y9S9xqFhzLai9?=
 =?us-ascii?Q?vHltBCyhQt/7N6pWz1tcCflt8d/Lx7bMMqsG4cgMRaT1HbPZ5BhmVFh2kw80?=
 =?us-ascii?Q?t4DRLxNEjoqZs20qFlDtBFNO1UKQlgjAhlJZy+Jst2NagPe2/DQVAliKnpbF?=
 =?us-ascii?Q?+Lee9H2wLTTzrb7brA1545jWGeEy+bqcoOeGq7zOPE1krGkDEBPlrrRuRPoO?=
 =?us-ascii?Q?wwX7hIxTIA4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OnRD/3ob3y2Swqh3CLb6lfNmP54vQ+gw8nJargfpFlTkq5F+aiOheR9TLExh?=
 =?us-ascii?Q?K0O22B9cTv+KpAw8eIsnHsRDawtOVi38eIjjj11tocFWIxJcwN0KSjPmUX5Z?=
 =?us-ascii?Q?6biGgRzGLngmLlvaUK7ldqyb7f2MguFntU9VzXM2fi7sTPgDKTIR40BERavw?=
 =?us-ascii?Q?7YaTwRtLHYCJsmdd7G0aiR3NMZeKfXKpZXF0TmMHsDniIZ9CqB3R5h9/sxBd?=
 =?us-ascii?Q?cDgrmxjA8eYx4LtlSOXqahhjWl6QDAjMiAm3MaeTDeT0+NRw9MQ7UXzUZ022?=
 =?us-ascii?Q?IFSg+7PlpSytqLzqERTzFNrzhUzsx2GUMGP1Tqiw0vZV1cOk6mEKLS5KxCQA?=
 =?us-ascii?Q?F1oZD34R5s9jjm3WJU2twG/iv6Kr5REYx6zJf3BxP1k94CvdeMwQR0sX6Kf6?=
 =?us-ascii?Q?Mutl2qESuAxnhA9zkCTED4V0iyT+Ff9lYv7UTlVR47x3kSrL4gFp1Os7+6l9?=
 =?us-ascii?Q?sNsWMEZ3B9haxJK/BPFTRNZwRXKZnmA5VRzfo4HmA9OKPKDZsTBPQ12KSYTN?=
 =?us-ascii?Q?GILFo6aaqCrPPRu1WsZIhtefVhpmezyOC+O0vLLE/B9A2ygWJAT+7E/vKS/x?=
 =?us-ascii?Q?ga+jroVlj1vZxJED2FX/2tv5DlZ0m1SGRZ6x5AO+MB+w/limN/jRhVQWSn1u?=
 =?us-ascii?Q?vkOFRH7NFYpkNPHGlH4gIcITkO2z//G/FVNiFMiyvBFxJ+0AYjWSx6tiq9La?=
 =?us-ascii?Q?4l/ou0FbeT4UCqImTE+B4/vcb8ozL0H0wKuQtKSlnhXOnzW7MBLEp/3JG92n?=
 =?us-ascii?Q?TMy3HTpuU2XTsFPEOPxTIXmoUvdvPQ39HEfoAt9xEzzn1Ii2iXm64diYTQfK?=
 =?us-ascii?Q?ha43DmLB+sZFAIsnX9FcRfgn0Ny7SHDsiLwPZ/BPmyZ5R73Rj7/Uqpa38vXX?=
 =?us-ascii?Q?zgkrEhReSCb6U9ZY4XEDtYPLIM8VRsOq9WPfszGwOS+YPBmh7LH0cuccK+GO?=
 =?us-ascii?Q?Jgm/qJFwS2bkjt+vk5UwXV9OYhfZwt0sSyvuMhAP/EeWEWQZpLX7YJogn/Eu?=
 =?us-ascii?Q?ikZD7Yl/isMpqUl0b3r85YLRKHWnDyReJZrKPKJZfjfkZvRgX3aXFMpZrhPJ?=
 =?us-ascii?Q?a8tRm9w1+uKF2w+pWijg1r/GnjZQojGPzVHOxDk3oy0nID+uvQyWmYsmKWeW?=
 =?us-ascii?Q?0DlnlDrDPdwQA8tXP4NWpBvjvcWESBBLoHDsY6xVjbX/UuLwj4CT0ZGWGsba?=
 =?us-ascii?Q?dQkTGZlPWx17jg0m5cbnM4HRihpqLTrc6O9OzlBozVdZe59pKGU9nRdhOJ8t?=
 =?us-ascii?Q?WfpB26XlvaD6s0VgoomJbdywnF3BnagR4Rx0m7T+UlILPDbNWh+lp8X/gYIx?=
 =?us-ascii?Q?NvQ5kJ3HrZjN2S+E+QxvSUmFa0ZM/sAbmd4aY3bqyzcO58YdsM83buk04Esa?=
 =?us-ascii?Q?FiLmP/ebuxl6DqkSekOfZIm2O+u/rL622ZnSSjxhc5auTnGjeVKZ3wRfSpVy?=
 =?us-ascii?Q?mT6d/e8RTHyE0zJF7HkGEgVTZG0BtF3WuXubb6mksbV7P/v/lh8nG6SACp7D?=
 =?us-ascii?Q?vje5xP/tp37O3okvU1BrEEK25pg1NRYlJGQHAR1tDk8WBhjyN7fwKfOnMvuX?=
 =?us-ascii?Q?5MqmhAs2SKDq1f3lduB0G6afvujNEuZwAvqC0Ft0?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7ff26c9-1588-49f7-1d23-08ddf13322b4
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 13:00:08.5986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: widVrn8YxlXEDexgTYy8msZUJDC21OxPlQ7dDSA21NxKDMXiaq7dQI+ajdlYxRpUGGHRhhCXAfUgFCtUzdaZRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6675

On Wed, Sep 10, 2025 at 07:41:47PM +0200, Sabrina Dubroca wrote:
> 2025-09-10, 20:08:03 +0300, Ido Schimmel wrote:
> > On Wed, Sep 10, 2025 at 04:29:35PM +0200, Sabrina Dubroca wrote:
> > > 2025-08-31, 18:35:49 +0300, Ido Schimmel wrote:
> > > > On Fri, Aug 29, 2025 at 09:54:26AM +0000, Hangbin Liu wrote:
> > > > > Some high level virtual drivers need to compute features from lower
> > > > > devices. But each has their own implementations and may lost some
> > > > > feature compute. Let's use one common function to compute features
> > > > > for kinds of these devices.
> > > > > 
> > > > > The new helper uses the current bond implementation as the reference
> > > > > one, as the latter already handles all the relevant aspects: netdev
> > > > > features, TSO limits and dst retention.
> > > > > 
> > > > > Suggested-by: Paolo Abeni <pabeni@redhat.com>
> > > > > Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> > > > > ---
> > > > >  include/linux/netdevice.h | 19 ++++++++++
> > > > >  net/core/dev.c            | 79 +++++++++++++++++++++++++++++++++++++++
> > > > >  2 files changed, 98 insertions(+)
> > > > > 
> > > > > diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> > > > > index f3a3b761abfb..42742a47f2c6 100644
> > > > > --- a/include/linux/netdevice.h
> > > > > +++ b/include/linux/netdevice.h
> > > > > @@ -5279,6 +5279,25 @@ int __netdev_update_features(struct net_device *dev);
> > > > >  void netdev_update_features(struct net_device *dev);
> > > > >  void netdev_change_features(struct net_device *dev);
> > > > >  
> > > > > +/* netdevice features */
> > > > > +#define VIRTUAL_DEV_VLAN_FEATURES	(NETIF_F_HW_CSUM | NETIF_F_SG | \
> > > > > +					 NETIF_F_FRAGLIST | NETIF_F_GSO_SOFTWARE | \
> > > > > +					 NETIF_F_GSO_ENCAP_ALL | \
> > > > > +					 NETIF_F_HIGHDMA | NETIF_F_LRO)
> > > > > +
> > > > > +#define VIRTUAL_DEV_ENC_FEATURES	(NETIF_F_HW_CSUM | NETIF_F_SG | \
> > > > > +					 NETIF_F_RXCSUM | NETIF_F_GSO_SOFTWARE | \
> > > > > +					 NETIF_F_GSO_PARTIAL)
> > > > > +
> > > > > +#define VIRTUAL_DEV_MPLS_FEATURES	(NETIF_F_HW_CSUM | NETIF_F_SG | \
> > > > > +					 NETIF_F_GSO_SOFTWARE)
> > > > > +
> > > > > +#define VIRTUAL_DEV_XFRM_FEATURES	(NETIF_F_HW_ESP | NETIF_F_HW_ESP_TX_CSUM | \
> > > > > +					 NETIF_F_GSO_ESP)
> > > > > +
> > > > > +#define VIRTUAL_DEV_GSO_PARTIAL_FEATURES (NETIF_F_GSO_ESP)
> > > > > +void netdev_compute_features_from_lowers(struct net_device *dev);
> > > > > +
> > > > >  void netif_stacked_transfer_operstate(const struct net_device *rootdev,
> > > > >  					struct net_device *dev);
> > > > >  
> > > > > diff --git a/net/core/dev.c b/net/core/dev.c
> > > > > index 1d1650d9ecff..fcad2a9f6b65 100644
> > > > > --- a/net/core/dev.c
> > > > > +++ b/net/core/dev.c
> > > > > @@ -12577,6 +12577,85 @@ netdev_features_t netdev_increment_features(netdev_features_t all,
> > > > >  }
> > > > >  EXPORT_SYMBOL(netdev_increment_features);
> > > > >  
> > > > > +/**
> > > > > + *	netdev_compute_features_from_lowers - compute feature from lowers
> > > > > + *	@dev: the upper device
> > > > > + *
> > > > > + *	Recompute the upper device's feature based on all lower devices.
> > > > > + */
> > > > > +void netdev_compute_features_from_lowers(struct net_device *dev)
> > > > > +{
> > > > > +	unsigned int dst_release_flag = IFF_XMIT_DST_RELEASE | IFF_XMIT_DST_RELEASE_PERM;
> > > > > +	netdev_features_t gso_partial_features = VIRTUAL_DEV_GSO_PARTIAL_FEATURES;
> > > > > +#ifdef CONFIG_XFRM_OFFLOAD
> > > > > +	netdev_features_t xfrm_features  = VIRTUAL_DEV_XFRM_FEATURES;
> > > >                                        ^ double space (in other places as well)
> > > > 
> > > > > +#endif
> > > > > +	netdev_features_t mpls_features  = VIRTUAL_DEV_MPLS_FEATURES;
> > > > > +	netdev_features_t vlan_features = VIRTUAL_DEV_VLAN_FEATURES;
> > > > > +	netdev_features_t enc_features  = VIRTUAL_DEV_ENC_FEATURES;
> > > > > +	unsigned short max_hard_header_len = ETH_HLEN;
> > > 
> > > Going back to this discussion about hard_header_len:
> > > 
> > > > hard_header_len is not really a feature, so does not sound like it
> > > > belongs here. I'm pretty sure it's not needed at all.
> > > > 
> > > > It was added to the bond driver in 2006 by commit 54ef31371407 ("[PATCH]
> > > > bonding: Handle large hard_header_len") citing panics with gianfar on
> > > > xmit. In 2009 commit 93c1285c5d92 ("gianfar: reallocate skb when
> > > > headroom is not enough for fcb") fixed the gianfar driver to stop
> > > > assuming that it has enough room to push its custom header. Further,
> > > > commit bee9e58c9e98 ("gianfar:don't add FCB length to hard_header_len")
> > > > from 2012 fixed this driver to use needed_headroom instead of
> > > > hard_header_len.
> > > > 
> > > > The team driver is also adjusting hard_header_len according to the lower
> > > > devices, but it most likely copied it from the bond driver. On the other
> > > > hand, the bridge driver does not mess with hard_header_len and no
> > > > problems were reported there (that I know of).
> > > > 
> > > > Might be a good idea to remove this hard_header_len logic from bond and
> > > > team and instead set their needed_headroom according to the lower device
> > > > with the highest needed_headroom. Paolo added similar logic in bridge
> > > > and ovs but the use case is a bit different there.
> > > 
> > > I'm not convinced removing adapting hard_header_len on bond/team is
> > > correct, even with old and broken drivers getting fixed years
> > > ago. hard_header_len will be used on the TX path (for some devices
> > > like bridge/macvlan via dev_forward_skb() and similar helpers, for IP
> > > tunnels setting their MTU, and via LL_RESERVED_SPACE).
> > > 
> > > So I think we should keep setting hard_header_len to the largest of
> > > all lowers.
> > 
> > It is not clear to me why we are setting hard_header_len to the largest
> > of all lowers and not needed_headroom. While bond/team allow
> > non-Ethernet lowers (unlike bridge, which is also adjusted to use this
> > helper), they do verify that all the lower devices are of the same type.
> > Shouldn't devices of the same type have the same hardware header length?
> 
> At least not with VLANs. Both basic ethernet and vlan devices are
> ARPHRD_ETHER, but the hard_header_len of the vlan device will be
> larger if we're not offloading:
> 
>     dev->hard_header_len = real_dev->hard_header_len + VLAN_HLEN;

This looks like a remanent from the time before needed_headroom was
introduced, aimed at making sure that the kernel has enough room to push
the VLAN tag when the hardware is unable to. I believe it should be
converted to adjust needed_headroom instead. Otherwise, looking at
__is_skb_forwardable(), an skb might be forwarded to a VLAN device when
its real device does not support Tx VLAN acceleration and dropped
otherwise (due to a smaller hard_header_len).

Anyway, I'm OK with keeping hard_header_len for now, but ultimately I
think netdev_compute_features_from_lowers() should be adjusting
needed_headroom and not hard_header_len.

