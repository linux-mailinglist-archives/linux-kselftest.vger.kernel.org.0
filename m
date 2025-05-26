Return-Path: <linux-kselftest+bounces-33814-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DCDDAC4369
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 May 2025 19:20:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39A5A17640F
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 May 2025 17:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CAF320C038;
	Mon, 26 May 2025 17:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NUjbZfao"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2043.outbound.protection.outlook.com [40.107.101.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34341D54FA;
	Mon, 26 May 2025 17:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748280045; cv=fail; b=Jkmkbq+Pb7ComnkgQf2iqFLOpZqXMEsboOGewRYsKLOfHt2POhXo3IByXo4XotD9E2BZlDtafZt8bU7CjbBhv2dw0rZWBtYgfCGEnmWa+pBMzOMC+4cjyFBV+Ip8UrCbdBnrxGu3qOKdv3Ol9Rl/PMLbCpsWG++HiUu8B0TNMI8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748280045; c=relaxed/simple;
	bh=Cdbmg9wrnaWJt8K5ur1YkG1scYnB4MpASCn0lKYQw98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KEObv/laecL8JLLhaE+F/DgLD56mpSyyY/JdpQLRBHqWMlLQBq9bzCUDMQ0wltO5ajeegZXu+U78Ob+muaxT4jPeCi2zi1qyE4Cyd7R/bXd/jn0gxsDce17XZSDiFKwxjgm6DwU+zjy7n4kNIuKNLYeO+kLkw8/qEve0irqk/yQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NUjbZfao; arc=fail smtp.client-ip=40.107.101.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JsGZb5oDxuB0IAKkrV/KQvV6mbiPHXP4GMjAehxEg+OFeCt2O3Xxh5t9V5RqQf91iGMUv5wWjsxrfZpSv9K5aMZSdGVVf/kxLz6IV/MxMdN5Swdtsh/cESe6Op2sLmz+wgvIuyHV/RN24ZJjmq1RB8kwmW+ZyO8dyYyDzQlfmBjDHvkVRH4KRI5V/gSXiV2x+gi2wqEvOWPmeANSXwsUMI/1Rtum6Te0N+54Vtt6N9i38AQvw+ba9Y0goukfbnq0BqgCb8T8H8OyWB9T9gNYRser6OjNez4HGpuZwwvoFMR7uVWsieVAzjJcqLGwW/NbsIKjYyHr8N6fMoadnLIECg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cdbmg9wrnaWJt8K5ur1YkG1scYnB4MpASCn0lKYQw98=;
 b=v8neGPx1BnTweQEZ562lwYF0WUk3prL8BVZrw2+NjcfFWKicJO6uomhew07k1u2WDVDvXZZ7QJsE/XG/zT8qlIYZMYlbdnIIukzreyv+LNsdSHVruIzOBz260TpidsntBB0rN9D2BY3UGTTx/q2IEkbkC7Q3I8annrPR1yin5Rp5TQfRZ6AqOlfQA4Wx/UnyfmTsafDrIrkQYT/vUJ1Dbfx/yYqUF6AMKUpA4N2QzXcWT7yQEF4jaV+aHekNTmYHhsDg9wzoTxOAsNNo2s3hNtdLKX30d6cdhWCUpI/ZwjyKJecBuvIjcruUO11ZNxfl2skpUN/9c7Wu506InrLXmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cdbmg9wrnaWJt8K5ur1YkG1scYnB4MpASCn0lKYQw98=;
 b=NUjbZfaoEcmn6gqFBrf+74yyDOjOJU4QAassE1Z0JVF5+cc0BRMdH2HSAclqZhwbWme8fIhUqqjh2Gb9AJIBz2Pez8wPdT/9aeJj3lAAJ5u9+K7J1SylqZz+Ys2mEEgZdmIvnXI99b5dSrC4tPF1tTGpHB/znfGblz9fObtq9S8+9aipiZivCBkqqlAU9FzohVwCAb2PiDjOswipyJIYsv+00mCTv0jlBJWW8rzF621SL4eOExsD9FWNAKmJbrxKJX+alzBp2iZ+XT9WVyDfBHo5KsXF/QaKvNnwz81ClpsG4RN92avFdxSJMsHXDmvmRfHqsgbOycRK8mi6+5Y+jQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by LV3PR12MB9330.namprd12.prod.outlook.com (2603:10b6:408:217::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.21; Mon, 26 May
 2025 17:20:41 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8769.022; Mon, 26 May 2025
 17:20:40 +0000
Date: Mon, 26 May 2025 14:20:39 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: David Matlack <dmatlack@google.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
	Shuah Khan <shuah@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
	Vinod Koul <vkoul@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Adhemerval Zanella <adhemerval.zanella@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
	Wei Yang <richard.weiyang@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Takashi Iwai <tiwai@suse.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	WangYuli <wangyuli@uniontech.com>,
	Sean Christopherson <seanjc@google.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Eric Auger <eric.auger@redhat.com>, Josh Hilke <jrhilke@google.com>,
	linux-kselftest@vger.kernel.org, kvm@vger.kernel.org,
	Kevin Tian <kevin.tian@intel.com>,
	Vipin Sharma <vipinsh@google.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Subject: Re: [RFC PATCH 29/33] vfio: selftests: Make iommufd the default
 iommu_mode
Message-ID: <20250526172039.GH61950@nvidia.com>
References: <20250523233018.1702151-1-dmatlack@google.com>
 <20250523233018.1702151-30-dmatlack@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250523233018.1702151-30-dmatlack@google.com>
X-ClientProxiedBy: BL1PR13CA0029.namprd13.prod.outlook.com
 (2603:10b6:208:256::34) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|LV3PR12MB9330:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f73b1b5-1596-4df0-444d-08dd9c79a385
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AWQHD4OZeu4QA4BWXeKiJj5hPXfLL78FUHRVZT8bXj7gLMQwsIGcB/nHx7Cp?=
 =?us-ascii?Q?SqWIn+DCGB59usXm4VQH6EyWgFKruVuPcJ6j0dZA+IO77+iVra0liR4QU8b6?=
 =?us-ascii?Q?7wja4aNdDkdgNlCVTHMXILZ2Y7UlarlP8IMmd61wP12LynEWZwCrghtQxG91?=
 =?us-ascii?Q?GfNV+Lv/I4OrOsPxTJkEpS8Z9zwRmKK2n1YUmnaZ6D+U+3YX60vJL4h+3oxU?=
 =?us-ascii?Q?zj/LBNk8ZGvPXJhhMCeYp5PttVvc6LB9P7kkCNM03W7tMfA3cnbEXTXQ11Ll?=
 =?us-ascii?Q?+F6arzqQFnSrNXFsgNgVQKrLO/EybFBKnhCO3w0sok69UiL2SrcxJCHsaTeX?=
 =?us-ascii?Q?Y3GTsBzogxM4L5e4TtmAU6BgDNX+zsJAO0ZbQDROnheilBP7Muife4Q/DtOr?=
 =?us-ascii?Q?Woxzi6Gap5vHnpzfuqf1vSlsBz1dJZFT+Vipu+mVXACmryTxpFkDGPLUQqgQ?=
 =?us-ascii?Q?JCPb7tDxnWuv2cyrbi5CEQa3KheiwbzjqULLBB+8d+CLo4flbpIs5CM+2rvm?=
 =?us-ascii?Q?+HkK6kECnV/FFHuhw2Rk70rl15i9r3i5OGpBo9mxDYUpUvKqKZr56oiY4EHS?=
 =?us-ascii?Q?XItCtNQvdMfe45LeIdOXFaGmup9QeeMtFFO2jXGB7P4f52jFxAA1K0J7n+8u?=
 =?us-ascii?Q?lPPNc5F8wALDQWZc2o0SkNBMFSolkFz1rJO7VthdoxA95wxkvrid1a0j03EO?=
 =?us-ascii?Q?d4LgvLlg8kXnZGQsb3QVNpgYPC4jNRTZfTtrHf/sG/mw2Pu+ZKkhxgxsi9/I?=
 =?us-ascii?Q?SiNt0EGdDyvPdLTxYHlLVs/vsQ3qUtTjEtC5avmpIzMgJbdlrdmBgTDHlhuE?=
 =?us-ascii?Q?svRjbvqWQJ3/hds7WODZB7UMqs5tmaOr30n0/hDBZzLD8TYEia0EkBj5ywm1?=
 =?us-ascii?Q?1SRGUeZ+lSDl7zwnnScFflxrgYpYWGkcloef+cCskiLDJur6j21PWDURVDfh?=
 =?us-ascii?Q?dE/HIxbgDYgc7w/f3HUZ88hjF4EvxlZS7D9DzKzLhxu5k9gwiT0s6+7kM+RE?=
 =?us-ascii?Q?ahNPw3MWKwkXoyguyVaj1VM4cT8cq2Ba87ejvxDQGL1MW42EoL8U9B/7o4s1?=
 =?us-ascii?Q?MfRcOJhitosAp76JZvf4+gN6x3ph1aYw6jfJOSeF22CIiPDy6T/gJYw6mIra?=
 =?us-ascii?Q?gkwL6pBSbioCvKdAApfgn25HGHb1JywlNWuA+z7nD8ATaihbpVIdeaLlDmWs?=
 =?us-ascii?Q?KEr6dVFSNSGJx9mSpDiNZzxLbEleckcPJSJrmeR257op5gdmVUHHj1f525aQ?=
 =?us-ascii?Q?bpakuQ1HzgOtp7+yJAdMkZLcqrwMNP3Av0RisKAoLy/2KdYVc2PC8Z3s2vaR?=
 =?us-ascii?Q?oNqlvZLJ+defVNkRWGoI0l0HSA8hIX6xnXO1fwjfI0zruoGqC9K/tA8SB/kt?=
 =?us-ascii?Q?xLRkK7lxpDoft3pci976Ti75miDN7qSeSimmU1EX4Jt7kV2buA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GTRpO6+JXQGKeLc1SZNRiD71isJ+SEnyZfF3+SZEDsnghJRP0SzfXfxCoRZM?=
 =?us-ascii?Q?ikIEXts1zON3nN9P96W3qZ4Kt9cv5KZXiJ5gbPqZcz046yASE4iTAYt41lad?=
 =?us-ascii?Q?7RecUYYjjOT+M5JHYDf4fE5dOKP/5NfADSkEjDYUPQcXaLlP1k35izwfcHGp?=
 =?us-ascii?Q?Z3vgN3w2jYxLqBRdmgHOZ3aLS60MhdfrYA84DnWyFsxCTf1mIRMKMD1+LZUe?=
 =?us-ascii?Q?CRAXqKCdxQzv/rFsiVLtogRS5Iwz8FK9gGxGeCfnflfxLT4fWJcnwn6QicpF?=
 =?us-ascii?Q?tqwWSmcFYon9KOj7EwCM3cjrES4/s+N7OqNIJXidzVwNjxvqNWsrHpTY0u5c?=
 =?us-ascii?Q?Y1AThtyXwBTrBdqiAF0XHTNe4tE+jy6AOi4U7Or2Y2ZqJC3xjUnBq83Ejxvf?=
 =?us-ascii?Q?J/s0kTyuYgCtoTzWWF9FH/dCaECIK4pgApTXGcVJ57DAqEDcaSwaUaec871i?=
 =?us-ascii?Q?Dyk+jq5Tj4I1pwDsI9te8YOD7/HIAoQ6DVCX8quu4l0l/zI3n8sURRtfVF8k?=
 =?us-ascii?Q?Jmj86Npf001wF5zy8xE8xsSSUpm7HVP6GmNZtNZ1PiFm5362m34LnLYsIT/T?=
 =?us-ascii?Q?ygqFwdjKir+7z9Se07WfLGnoRXYKstpkdyOSgPo31CHjW1Oq3+ovsysMsY/X?=
 =?us-ascii?Q?HKTITpttdCjDn3qLmoeuANyXamZ+DSZaE+ZcvT668WSm8OcIpuXkIruzq/y+?=
 =?us-ascii?Q?LpQ14uMPo++3LnlEOG8T80xExw1FksqVAcnEnY7v0gdIQ7kQQHelRXtZi70x?=
 =?us-ascii?Q?eMrAeXZLdv6aOCH7p2uHx/98Pis86wqSzhCTaeQ6XZ4jXTXZ6lwGHC3upzpz?=
 =?us-ascii?Q?92O0qEWZE+HbvIrBjJ7VttVwMpkvqVfwA4aVYIefahkJev99c+K4HctIDW/b?=
 =?us-ascii?Q?qoutSVwE+SbbFEIzIfbFH4zdQc02WLXdOj2HGoYPq0buxjnK61kGTEnbgp6L?=
 =?us-ascii?Q?QXl8Xn1K+vOL7/p3XmC+3nAHxbAzwdqoDr9SnYDs5h137ZhoTHeocuG6dLRd?=
 =?us-ascii?Q?BVgj+UTs54H4IGll7RyUmKc5RNj3a8VPCzLaD4Nsj3OxjDd/ZmLEIY+IsZoz?=
 =?us-ascii?Q?5jkOlNJ5iDJ79FsmWwAyRaIH0Nhq7ox0hkY6bZocZUEoGuDR8O+/GV9TwF/b?=
 =?us-ascii?Q?E7ZjluP30ZgwqrwiV8b5A/LY9EXWpa39yd9IZROuTjh+uVAT3II2+9xNtG/6?=
 =?us-ascii?Q?bSWwcRG6QnutvN1AyWm77b04XomZe0b/3NfGeuiSztTZzUgrMnSOhKOZQEct?=
 =?us-ascii?Q?biAWT85Av6wYqJ73QsLfc4jqk/cZyZ8735QfR3K5aMPYGjg3LUOCSQQxzEXs?=
 =?us-ascii?Q?KA81HJDaKcSuiVBTMxLJNZd7YiKJA5wK56GQiipWwU7F/n13URElTSXfcPo7?=
 =?us-ascii?Q?hbRi7dPQwcapm7tuAdW3jICK4E6W2/MatebUqg65qFDmXpbj1W5RTIVjOQ6d?=
 =?us-ascii?Q?xUl7MwjEzHxn995kzxQWyZU3RqZ8rE8fP5pdP/AtibL/b4VoIGOxRjuJZBS9?=
 =?us-ascii?Q?FVdhuQkNjd3mIeoWua+5Dgy+H31AgB+U/FmXJsu6+ISDvQFwCW4kneNe1FAr?=
 =?us-ascii?Q?fSzwvsGKSa5FUxluPW1D0C1lZZv+981nL6ml2nHf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f73b1b5-1596-4df0-444d-08dd9c79a385
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2025 17:20:40.6878
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NIuBO8WiYDJ3HHoF+tu6y/5Z8yW406qdmruTx629aDB4mNFXQnObnihufEyJOy1X
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9330

On Fri, May 23, 2025 at 11:30:14PM +0000, David Matlack wrote:
> Now that VFIO selftests support iommufd, make it the default mode.
> IOMMUFD is the successor to VFIO_TYPE1{,v2}_IOMMU and all new features
> are being added there, so it's a slightly better fit as the default
> mode.

As before, the tests should run through all combinations on their own,
use a fixture.

It would be much better to fix the kselftests so you could regex
select the tests to run and use that as the commandline way to choose
what test combination to use.

Jason

