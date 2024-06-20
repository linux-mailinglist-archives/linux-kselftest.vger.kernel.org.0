Return-Path: <linux-kselftest+bounces-12378-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D07F911627
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 01:00:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B874BB23997
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jun 2024 23:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54F1412FB26;
	Thu, 20 Jun 2024 23:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GUedyVGU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2064.outbound.protection.outlook.com [40.107.237.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA3DC8FB;
	Thu, 20 Jun 2024 23:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718924441; cv=fail; b=IbfBfo+JFYIeNgBXh2Hyw9iU5I2D2KTqyMjBnM3S+nptdU7L2Tb+CEZhn8MN6iwZyoRlccAl6u0XYxThFOj4yNOoTagUgu6iwPEQbAslhkm9CWkeqpIncX33C9ll95/P4fzuSwR03qqVBWmId+jixhNIQMBkJQfZ3VuDWxyWQGc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718924441; c=relaxed/simple;
	bh=I8ZJQdsY8/Y/1LWG6CridaopU7pHMvzVVbrbl3zpDIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IZur9jjqNBIWhOmSjywPRhaXIsOSLyeQPF2IsWia6F2ciaR8T/7gTB9+kcGH6CFZSDc/VTypG+uV57Ni4RWEwzX1uNmtz9r3buoEAnDiKpMI2w9zZEprD91dhYuCGRzeqY87gULQ/9dISDYOFndupHG+FTMWiBrTjY5thxQaTvU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GUedyVGU; arc=fail smtp.client-ip=40.107.237.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aeKVnwnkS8XWZ07jhEUq9CStbj/11MKwxzOykGWusndRTTkjFNqupP2vV9H6PDI00ZYNwH/sORMhpXVhVw1KhPg811Xynol9wtqrayQ7uJVSsoyKBHilhmAtocL7RS6PiYiV12P13IadQFGWv/QF9j5e1ohVL8TpW3jQPd0jiBzDGA9fqYITt16VgS2TytzjrM4G2dtVDXG+ISLVy/eZ1eHTq4SWpn83f09tA0q8DcazqVn68N/08jR5lPxCZRKVaAUYwzygDIRcsxtoEpf7e+Aq2+3+fsgEBSpDpJa83FyW4hRqBdBtgsyIvXaGwWhJY+camSJ04t01tj4GffHLAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eNoZYajYtRexWXFmtIn1CnvVUoEvWa3DBCJXLk+eNXo=;
 b=YANpKSQbr9nVhBzDbiIbI5LG3bsHcHFSydhJ6Gndajhi3MAo3gaIQCspJnI7EmbCAHSqv3QjX00hwp3uGalFwV5xFIAFknecCzVDLxsiVgg0ZXc9fDtzqslGZ1wRi3sEP20TkPRgIYNJanWEA1RvZINeGcT6bWb+y1iiwFdlbKtpQB9sAp7cOEsM3Ty1lYqWGh8f+pPmOD+4p/uQannYsxKYZo55UgA/XJpmVhAjLNsu/qH5spRY3jme3MyEBsCg8S2haGgDwantotAq2EMqaIPnEGT2+FkGahGV8c31iX6BEIlkHSP1Y73cQdnCwfKGf+AURQUB3PnzfzmmJlEtkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eNoZYajYtRexWXFmtIn1CnvVUoEvWa3DBCJXLk+eNXo=;
 b=GUedyVGUprntuKUwuABAFXTtXEyiRKkpsTSXlExn1y/u2oeF3rjVuSudOcu1QLWyZT7B62UZevZzstqH7+mF+jR/Ztoh9ERBH4RlFu+QewizpoFj6i/eDdHXlZjG4n0Uowp803w9sdfQjHIe4sCdI7rHECL56b6YlEwbF8TiW2I1UzF193U1bP4vyNwVZr3cb1DKshf3rF5CpIRC7GEtdR/WYuC/wGIUrWyt0nSVY7DQk0kyDLdGXjdFeMStU8WZA9xxx19J3+UGfFBfPA5i5xOXzzo6L83HSTfwmCc68Xwg8IrALO8vjP8307S6TcJ6cFr2ZiGuNBu/1rtKbS0DEA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by SJ2PR12MB8690.namprd12.prod.outlook.com (2603:10b6:a03:540::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Thu, 20 Jun
 2024 23:00:35 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%5]) with mapi id 15.20.7677.030; Thu, 20 Jun 2024
 23:00:35 +0000
Date: Thu, 20 Jun 2024 20:00:34 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Sean Christopherson <seanjc@google.com>
Cc: David Hildenbrand <david@redhat.com>, Fuad Tabba <tabba@google.com>,
	Christoph Hellwig <hch@infradead.org>,
	John Hubbard <jhubbard@nvidia.com>,
	Elliot Berman <quic_eberman@quicinc.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>, Matthew Wilcox <willy@infradead.org>,
	maz@kernel.org, kvm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, pbonzini@redhat.com
Subject: Re: [PATCH RFC 0/5] mm/gup: Introduce exclusive GUP pinning
Message-ID: <20240620230034.GL2494510@nvidia.com>
References: <CA+EHjTxaCxibvGOMPk9Oj5TfQV3J3ZLwXk83oVHuwf8H0Q47sA@mail.gmail.com>
 <20240620135540.GG2494510@nvidia.com>
 <6d7b180a-9f80-43a4-a4cc-fd79a45d7571@redhat.com>
 <20240620142956.GI2494510@nvidia.com>
 <385a5692-ffc8-455e-b371-0449b828b637@redhat.com>
 <20240620163626.GK2494510@nvidia.com>
 <66a285fc-e54e-4247-8801-e7e17ad795a6@redhat.com>
 <ZnSRZcap1dc2_WBV@google.com>
 <53d1e7c5-3e77-467b-be33-a618c3bb6cb3@redhat.com>
 <ZnSt-_dkjStvT1WB@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnSt-_dkjStvT1WB@google.com>
X-ClientProxiedBy: MN2PR19CA0054.namprd19.prod.outlook.com
 (2603:10b6:208:19b::31) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|SJ2PR12MB8690:EE_
X-MS-Office365-Filtering-Correlation-Id: 26cb1eb6-f200-4077-27d1-08dc917ccb59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|7416011|376011|366013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?b2ooqjZa4i47BNfVbmKUvr2h6QU7peYd7CZWCN0mLhKbQCenNeFdIuc8hTdM?=
 =?us-ascii?Q?jbzoD0GNMwxi4M0Flu50EebOKxyh3JxCKGP70YifR4gg3qSrDLaScBzxHBDw?=
 =?us-ascii?Q?kQ2zDoYyWFMAxZ9duW88g1HbN8XMZgDBkwthynhi3tTuDx7t+ehdPFvD1DXG?=
 =?us-ascii?Q?61S1gDPBIFOJQ/mYJpDtszKUvB7OKpaGX0N281GWOxc6FBWWMZGHDk4z40RM?=
 =?us-ascii?Q?iTxatshOY2veB85iHx2S2KSzxsfUGCpkgHM2pIv1i+t+sU9UPjIsYhATc0iE?=
 =?us-ascii?Q?IkIsPjzfZHApaVZY5vKbRzIiXkGGKEJqT10/txnd9D0A6PAkdG3TntZaEy2S?=
 =?us-ascii?Q?KUSfWYyJ7Y2cFelmdtexn9LVthqixxpGcUyddjKxZVv7fofSfZFLs5evm93R?=
 =?us-ascii?Q?v4Gb3PpN2wRxopaeL7bTHuzbQXm42KpvJ4G3PngYYph+nkBrIxB3RuffJuDW?=
 =?us-ascii?Q?ysyMt4iUBB8NYI4iVL9IcLl/XjQjbt+hdmRlRpGuCNesjei0St53eNqRK2fQ?=
 =?us-ascii?Q?Q6YgiY4On2RxO4Vw6HyL7md0RV1XWw+gYtrihhKIucpM5pB7v3LGamy1HodK?=
 =?us-ascii?Q?csp2MSOBCki9b4Yl281fwJ/VMMDmQSjye4Due6n1ULosN/21tGzGzOlBF9zQ?=
 =?us-ascii?Q?3Fx4DP0pHzAK3Zm61SloykdcG9HSIdx7EMuIkfMkaTquPOPECjnlEKtfFjhW?=
 =?us-ascii?Q?9kJrQeJErishW94yW2LF8GhnYNKqvJxB850JPxE2k+4k3joc2qFl72wylFgV?=
 =?us-ascii?Q?QqDwjdPNxlRBGjPYP0DJddnq/3w7AYqmqx4NlhN++R3He6qivMPfZ6Hy0K8q?=
 =?us-ascii?Q?0siS0jfAWZCWEGfr+Nfa05VEmOcH1cJ5lbqwcTK9sE/5yV1+C9GvOoWVQ5DA?=
 =?us-ascii?Q?+zPumsNBtJ+fLIAmfb3LY3YbGP8S2eJqXIsd6oSIWoh58Sui8udgp6HVLVsu?=
 =?us-ascii?Q?C3RRdKlqa2Xg+q9kh9bOjN8gOowNTvPWxsRdVdTgBg9/a7j72YTyTgl/XZf6?=
 =?us-ascii?Q?gzH9shsGE7/1Dnv3Xyh+mt0f10m5g9TgJCx+k/UtJ2OhWLhN0XUANR/Uj6YA?=
 =?us-ascii?Q?PWv1+QoeQNrF4FyETljtmW4pfLIHRGW2Puxm7oLCNg8wm1vyAeD2PTBslBzU?=
 =?us-ascii?Q?mHsH4wiFbMW7NyWhjh1WW0C1Y2B50YslZsfYUZvzFLb/OS8KWbiS0Yr1Z6GQ?=
 =?us-ascii?Q?NEBsNR0aXHB8zfhbQTRqOUIAL/7XvESs/tOB65Qq9kZsLdVOhJBvaBDKNehf?=
 =?us-ascii?Q?aXZ5VSdwcrKJcUqd95s4T/tKoE2g+ET1DhqbbMUu5hiSLzbQbUMx2T7A4VuQ?=
 =?us-ascii?Q?fn4K8yWJk8gnHlraRURfHy3k?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(7416011)(376011)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jk8hP4kSJx8wmy6tIR/SqQsCbLziRC0ZyR8uU9BP0+Dgu1OC/A92nywQkShm?=
 =?us-ascii?Q?KwAWxfxObkAJpRDvmb+TVskeY9eeJOnyXgwusZa0emH44zyuMZwidGoRUuaX?=
 =?us-ascii?Q?IQhwSJcQVqVM+otivRB/5emJRX3WH8sW252ry1AwyBTwOtPI0cH9s4npOw3X?=
 =?us-ascii?Q?xZCg8L5Uqdi5wivttjo/nR/1YvkVIQkIaLzMgA3ATThbtfJ87s2BRB8/Ju8L?=
 =?us-ascii?Q?M5DhYjVlV1sMN6Va/1EPNOMGgmEN7lN+YbOCRYj3AVLHru8xjLDNs529RkX7?=
 =?us-ascii?Q?P9L1UvVWkYB89UP9fsgGM1B3SdHpStHI1wG8FppXami60aJ0NKaZ6MqOTZwc?=
 =?us-ascii?Q?8aPsQUr66ULGrX4/EkGmMpkWfibINo/2mkHb2N6vV5McCaaVz4qCVYYUzdRT?=
 =?us-ascii?Q?axBHIfZ1hbowoK49z8IDIBANqs5YZApdyfcS4nk1mH8EJAJOCCN6oqMVEMAQ?=
 =?us-ascii?Q?cHy8PDu5IEROc/u+/PLFonAY6OunXV7fHG6VsX1i22k7VnJ7YzWmb+ozdVVv?=
 =?us-ascii?Q?CracNftgDbpFg4yMeZ/4D0kNitB+fsVBCO0QJiSeiOBZRQu8lJjHVfeMpaj3?=
 =?us-ascii?Q?ZyY2QSFr/XabDoAyvWBt2df38qiygMURatkvqYQUw4iTO8gC7FNEUtNg3SRA?=
 =?us-ascii?Q?e/mA/vWzd2+fOrVwv2zZzOEsYQUKX+Cn6OqeGEb3yJ6TzT+xNFXoTVQoemV8?=
 =?us-ascii?Q?COabNxD0wLXWNizvH7x0m2EC0EPlIlqS0RYNrFqlrMFScA5j0iuzo6mxfOXx?=
 =?us-ascii?Q?SR9n7G0jEugNWlFa79zUFt5yJtYFH+eaKp4VzAm2Z6OcRHdpAp/iwSqSANhJ?=
 =?us-ascii?Q?J9sp2yTDJihfTqpl2RGeThI9BfTFsFmsLt+YIsGaCgl79B093/bFfCD6TKUn?=
 =?us-ascii?Q?/gQYoSrUeOx6pq1wRA7iK5aJOk59z3zZtAVOm22w/3JVRrjPxpfXJ9y8IvRk?=
 =?us-ascii?Q?qgyOZLUMaEhh16sWSQGosVLIaIwYbCXEI+94VNV8ZOa8gTfWVneWoAXBmYHW?=
 =?us-ascii?Q?Kxd1e8JIeqQQxp8vtAPd4MNq76CLNbcGa2qhTVSWRZrIc7ort+QmMePT9F7Y?=
 =?us-ascii?Q?c5gT10F+/CXwF/SMO4N2F6h1X575TXn/N5Et7roHRItEvOEXDxlUaJUf9LIg?=
 =?us-ascii?Q?/fOEkW9SrBOwjFge6F1I3OSC1hsfVKTAuKzxTH8S6bq4BNJTasgE6w2LCqUt?=
 =?us-ascii?Q?0PrMm7uAvZcJjEinmxYfGTld/OJl7P4nP1NmwsLAbEimBsyCC7M0Z3FKRhLR?=
 =?us-ascii?Q?91ehCuDS6e5RmROO77HovPIQNVrVbOkeKpqKOdccUioLG2AAS59yUBowYpHL?=
 =?us-ascii?Q?A4BZFwN+I8QbjRrmP8uXeawpN80PJOD/faKY8FMi5+ESVUDlOAV+gUP646kQ?=
 =?us-ascii?Q?U/VlZm9trmIjcRM75312HLbAMjfe2IDBjA2d8XjqOaCvwL+0i6YqZM7Q8U9R?=
 =?us-ascii?Q?84yLZntvu4U17PWYP8T976RlnkcdkbVO9XA4U+oY5deQT+EMqa+y4hWo/g/0?=
 =?us-ascii?Q?FhpaZhHDuWDJ9m6QVDCad+HhtIZZiP3MCaQYp+cVodP+RORibilIqD6db432?=
 =?us-ascii?Q?C70GQd56SRgjE4EIrkU=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26cb1eb6-f200-4077-27d1-08dc917ccb59
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 23:00:35.4623
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WSAyCpQERaqJ93kg+HBUzgzIdxaTmS+YFEyPDAt6X01Q3GOqUM2MJvkZTSKUW1l6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8690


> This is the step that concerns me.   "Relatively short time" is, well, relative.
> Hmm, though I suppose if userspace managed to map a shared page into something
> that pins the page, and can't force an unpin, e.g. by stopping I/O?, then either
> there's a host userspace bug or a guest bug, and so effectively hanging the vCPU
> that is waiting for the conversion to complete is ok.

The whole entire point of FOLL_LONGTERM is to interact with
ZONE_MOVABLE stuff such that only FOLL_LONGTERM users will cause
unlimited refcount elevation.

Blocking FOLL_LONGTERM is supposed to result result in pins that go to
zero on their own in some entirely kernel controlled time
frame. Userspace is not supposed to be able to do anything to prevent
this.

This is not necessarily guarenteed "fast", but it is certainly largely
under the control of hypervisor kernel and VMM. ie if you do O_DIRECT
to the shared memory then the memory will remain pinned until the
storage completes. Which might be ms or it might be a xx second
storage timeout.

But putting it in the full context, if the guest tries to make a page
private that is actively undergoing IO while shared, then I think it
is misbehaving and it is quite reasonable to stall its call for
private until the page refs drop to zero. If guests want shared to
private to be fast then guests need to ensure there is no outstanding
IO.

In other words the page ref scheme would only be protective against
hostile guests and in real workloads we'd never expect to have to
wait. The same as ZONE_MOVABLE.

Jason

