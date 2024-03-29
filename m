Return-Path: <linux-kselftest+bounces-6879-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B6C48922BD
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Mar 2024 18:28:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2ECC51C23A57
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Mar 2024 17:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14A17137765;
	Fri, 29 Mar 2024 17:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b="mSIt+BXW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2096.outbound.protection.outlook.com [40.107.220.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4247E137755;
	Fri, 29 Mar 2024 17:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711733304; cv=fail; b=KzNC3Qd9T4iz9jB9C/yXmVljOHZWYfbBxTvjdoavDC29sSHNqhM/goVNKD1t3rCPrSgDeLcMZRRWXhbvUF4SvonSzU1qMDnROk8Z3IfiEW+32oP5b/X9uNnJX/lX6CrtY5WrqfGzdMEHVZE73IzTgFC/UJfA2fCJuDD8MSWUr0c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711733304; c=relaxed/simple;
	bh=Rv2zBxkafJWHjq9GslKeDMxiLeU57/dM4wJtE63niiA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=R7oCnCoy5hwqKDAzZbrksgSM4ENIXdrYUjYS9dcShJvdjqXMJsWYoIFqTztFR4MieOWPiEWtKnD52LAVP3Ghy0I/6cZkvJKNhzD+Q4g/uUut/iK9FJWhkYk3ZqcGbcwc5aCGHSn1zhnEQ+Aj1tXKASoj9T3X6qnWoUEVzOzO1cI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com; spf=pass smtp.mailfrom=memverge.com; dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b=mSIt+BXW; arc=fail smtp.client-ip=40.107.220.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=memverge.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YEvSK0jIhcwrjKLKyJ3CnWZ9eAAoLf8QUiod4PP5VJR+QGv7qhUDqCahDTuBiTipE5Bqmw502i3Gy3cqJcOH/PuqG7j7UuQbVvCYANmbnDotXuepWTHVCnZxSbd97ig8qT0N/cMG9NEi7GydnEG9tToSoYv7uGN8EiNWMK7IcilFuAVJrxf1k/e52XolPHWt0TFPzeE53oFeVel8Khq4G3Wi1+ds+0VMMP/ewIPIyflDtYym3v8HzBlTjAk1mQS5LigkAzJ4v5WFzj5DQ73iz8tvVt4LKoYIpNZFz+3axk7hU8uCt57qUM3jPKay8QkIqXJrV7GxmDk5bwHdAmJ4IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5FmNv599+nh86396q8j8OJAB8UeEzwCNMcoM6fgFtX0=;
 b=YX+NqJ7kiBcgCU4WG3SLeukDxphuMq+ZOBSFnkyLxFmLOYnU1pdmPUsJsR9ohGEuBErTSZkpMd7lGA5Vkysgh/Oe4mIWsrmht2b5m613jdokpVya1T2sW09kW1PLzrUBhbxaw78b+HZZLURZ7op2IXwgRbd+HACvIE8pLanhs7BeTfhAYEGVhKQFX0Cm1foGPC1xDNigeaEf3zdzqrcZ2PvOsRZlMaqWd5C3pT4sPMY5dWcIe64F+qKOVJBuO1sEbQdEzAsxPFpTB4Q6vDdNy97a524pj0e4Kzy3o5E8cqBpU1Ub2f9BtdXimuxJeuDXlfw7gT/7mMVCe6HS7E1gOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5FmNv599+nh86396q8j8OJAB8UeEzwCNMcoM6fgFtX0=;
 b=mSIt+BXWj8HqoMUvd1NgeHHb3Bl7+CLmIV6e87qSW7W0vMi8WRWyQxatEItKFUizZs/AOP0WjLxbsHG9mF8YLycpUcJN5S65lSLL6NvPZ6vlTjHo4A2hgtwmcKpCVFj4NWJ1nuP9fZOpaAqZD19jl85/vt9fhsPaHjRryTh5ksc=
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by IA1PR17MB6213.namprd17.prod.outlook.com (2603:10b6:208:41b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.37; Fri, 29 Mar
 2024 17:28:18 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::6657:814f:5df0:bb5b]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::6657:814f:5df0:bb5b%5]) with mapi id 15.20.7409.039; Fri, 29 Mar 2024
 17:28:18 +0000
Date: Fri, 29 Mar 2024 13:28:13 -0400
From: Gregory Price <gregory.price@memverge.com>
To: Yuanchu Xie <yuanchu@google.com>
Cc: David Hildenbrand <david@redhat.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
	Khalid Aziz <khalid.aziz@oracle.com>,
	Henry Huang <henry.hj@antgroup.com>, Yu Zhao <yuzhao@google.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Huang Ying <ying.huang@intel.com>, Wei Xu <weixugc@google.com>,
	David Rientjes <rientjes@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, Shuah Khan <shuah@kernel.org>,
	Yosry Ahmed <yosryahmed@google.com>,
	Matthew Wilcox <willy@infradead.org>,
	Sudarshan Rajagopalan <quic_sudaraja@quicinc.com>,
	Kairui Song <kasong@tencent.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Vasily Averin <vasily.averin@linux.dev>,
	Nhat Pham <nphamcs@gmail.com>, Miaohe Lin <linmiaohe@huawei.com>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Abel Wu <wuyun.abel@bytedance.com>,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	cgroups@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH v3 0/8] mm: workingset reporting
Message-ID: <Zgb6LQndjoFVu4pv@memverge.com>
References: <20240327213108.2384666-1-yuanchu@google.com>
 <ZgSTNCP5f+T5VtBI@memverge.com>
 <CAJj2-QEg3+Ztg3rK6FpVVCxSG4DaDPWsO_bha5v5GrJazc5DVQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJj2-QEg3+Ztg3rK6FpVVCxSG4DaDPWsO_bha5v5GrJazc5DVQ@mail.gmail.com>
X-ClientProxiedBy: BY3PR03CA0013.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::18) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|IA1PR17MB6213:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	d8BDYxitSD2of22mrgkzudUDRsPsi3J4QRIX1aN6Hn47flVUu6/IEo8vXlu0VHBkIbZ8ZZwn4cEsn16gqx6qC24jYJoF/0lNLtz0HT8OAhnW93ZTS/5ykL3gvFn+Iwr6vR6mFuZPegtgUUM7vfrvJ8R8HhOSQJ7adpSbsha0gRnxNdiYbbZRp6F0qNMfW9IH6jEddIlPePMErn7j+H8l4HpdODZqhVq/+FVigrd3dl3txx0EszWm5MD8ql/Xpo4crUn7OHq6d/rnGKX6Qal3iJOeOh43ignbXv7LF8ErhkGlX4ygha8NZ+c0YuE30EAGjtU68ZftoVw/3hn0k9BHXf1fyHQcta5FB5r253BNO6SEZ1A+IxFSDwtpNSTMQXBTO+gGFrsPeo3jSraPARnDaOLUV1x0KJX385UKYAiohQjtYqQu4gpLlK+KnAnF0Mpk/+jA5YBtU3UgOgZVb7HFz2W6B6g0+/JjRaZNpMAefL4ntlLg+LlIGLmSNjrsvhI46/qp0ih2Pbk0orodHs7pymuwMU1dNHvEkNoavtX1JRjRPwd1xRId8UJ51Vrmu7jHNkbVRn3usVRoU8hJtPXnUenIKqogU1YflJXlH8kj6AeSiNBEj08O/YlUvnszHK5J3nkXaLvamXb6u7sdHGAeNYzStHO6OzOVt8v2+Ix3xos=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(7416005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?alY5QzNYOUFSOUNXUTVrVzYrNElGeGZJZVFKVURNdkpHZUdURnd4Q2dzK2N1?=
 =?utf-8?B?QnlvMG41aXJQcnlCTjNIMkdvbVZoNkVQY2QzNmNVQTk1YkRsekFIYTMvSjlY?=
 =?utf-8?B?dmpQVzQ2RWFsOXMxTERYWTdOaGlNNHBSSkZMc0lNSmUwbS9HdENtRGFIMi90?=
 =?utf-8?B?QVN3ekZsaG51QlljeUsxNk9pSG9ucVpYM3R5SFJFNWtsWGloUW9zSnZhWE5m?=
 =?utf-8?B?Y0VZaHAwTENQemJiUGRZWmN5b1oyaDZSU1hWK3I2VjNRWG1aTm5CelpuaG1s?=
 =?utf-8?B?T3lobXpDQ0xJYUtlSEt5a04xVzZ3WWNLZjZSZUp6MUlvVDBtTlVmbVZET1c4?=
 =?utf-8?B?NDdmZ3BXdjJRNTBLakJ3N2R4SERuUDJjR0RwUGkwS1BzL0U0SjhDU1Z2d2ZX?=
 =?utf-8?B?RXN0akdxeWFtS3A4M3FUbHhqQ1IvNXR0aTNQSk9qcU9ud25CZjIyOVlHVVlp?=
 =?utf-8?B?emhXcW5zK3pWMWZqSzFYNXYvUmJvTkFIK2tjUmY2UTJsV2hNb1FvUkdXNEQ4?=
 =?utf-8?B?RUtvZ0VGK1NtL2tBdzNobnk5ak92NTVBL1RZeWVWcFlSUTNKK3FMREFqWnBC?=
 =?utf-8?B?UEdlMFIvZ3RqWWhZd3ZMMk9acDFMTWtBaExvc3AreGRSRTIvMDM3RUI5OHhI?=
 =?utf-8?B?NTEvNyt4VkxhWlV3THRoM0dGVlVzVCt5cW4wNSsrL3lMTUszTmF3M0oyNGpk?=
 =?utf-8?B?eUFhMlNtZGF1bUFPcWZETHZOeG5iS0YvUHlDWGtuS2NQSHltSG8zUGlqdG5B?=
 =?utf-8?B?SXVQM2R1dHhSa2w5RW4rZWdrMDY1S1FjS0h0ZFNBbVN4dGtMbWdNTXJTSDhs?=
 =?utf-8?B?WUVmUkd2Y3FXaDRCRldBT0lPZEhXUVRmemtUT1BJdnpCWnVqQ2JqTitROTRr?=
 =?utf-8?B?SEVXenMxTzdDaVVNdTBNN1N3NWprSVZnZ25DYW1YQWpzVDNSZW5xcFVINDNH?=
 =?utf-8?B?NHVvTVdXbDl1UEt6Zm50U09nSGRXcFVtbVd1L0k0QjEyMFgzd0dXTGdNdkt5?=
 =?utf-8?B?RU45YUo2TkZPOVpocnA2ZFhTUjVNZGRDNGJhUEcvUlhtNmNnTmNJeTRFam1M?=
 =?utf-8?B?a2Zpblh5TmhxSVV0NUxRbDdxcElydDMwMnVpSWFLRjN1b3VqKzJ5RjhvaFF5?=
 =?utf-8?B?Y0h2dGNPUUduMXRpRUxJUit1ZEtIMnRTZXNsWW0zZVRYUEdzd1RGSzl3Rkpv?=
 =?utf-8?B?Vjl4empISWJISDNibmN3Qnlpem5ydWVIRUVlYjhGV2lpMDNyUEJ6eVcrMkNF?=
 =?utf-8?B?alBUSjZZbmR0aDBqVFRsS1hjUytVU3JCQnY2U1NJR1J5RmozTWdoaWdZQXZR?=
 =?utf-8?B?OVFzbUg4dkNFZDVOREErK0ovR29BS0hjK2ZmRXNCZVEvQUY3QzJKM0pXM0VK?=
 =?utf-8?B?eFR4eWRpYWVDZ2VPalVxN1JUUzg1cG1DN1FKTXRXanhNdlVpQW9LcWxoUVkw?=
 =?utf-8?B?b3BsekZXeXRBanlUQkpIWS9zbWFQOVBET0hnZ25IcURKS1h2T25rcHg4bEx4?=
 =?utf-8?B?LzR5UERNNUxSa0FMM1hBWnJUcXJxWWpFcG9EWHNYZEJrc3lnS09uSHNKbkZj?=
 =?utf-8?B?RmJocVp4ODRIN2liSlBoSU9NSVJuZHdncnhrSDdUUjc5aDZnRlJTRXplVFla?=
 =?utf-8?B?eUxDWjBsem5ncEM2THBKcUZXb2VzbEladzZFakJZbFBXbDRmcWFaelFWL2Nw?=
 =?utf-8?B?WERwNjRpaHQybTM1cU9CQmRpSTlkTUcwZkliMlVmamNpK2xMMGZ4RDdLSjNZ?=
 =?utf-8?B?Wk5tbWhrQWpabFF0STVmR05zUTdSN1RsM1h6SGFHYUQ1ZGtSYlRib09HRk5T?=
 =?utf-8?B?SjRRbXhvVTVxTXhuTGxEcnVPVmFGeGFCUnZOUlBKL2VrbkFoNkUrdEhFK2tS?=
 =?utf-8?B?RXFiR2hmWnVUdFFaZFoxWVcwcnVHUzRqcTRjM1djdWxhQ3VJcU9RaWNwbG40?=
 =?utf-8?B?d2dodkRtbEZFdkZtZE83N2dNOTNoRUhGbEVHK21KeFBEY25YazBaK2djV1BI?=
 =?utf-8?B?Snpza2pHdkNodUNQVXpXekFzeHhXbTN5OXlHNWlZQmUzZnpyZk1wR2RsYjVl?=
 =?utf-8?B?T3VaUG9IL005UFFzTzBSTGRhQmJXaWh2b1pVR1NvRlJwTkVLemR6QjRIR3lY?=
 =?utf-8?B?Ui9XcWprZEowZFRXbnQxM3QwOEpxbm0yZ0VVY0tuWldYbnRxc2M5dncyZjFa?=
 =?utf-8?B?aXc9PQ==?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f767b94f-d74b-4396-d193-08dc50159f9c
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2024 17:28:18.3368
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P3vWrgl5ZKYm1c/aLqaIIdgVn6LkhTeVw2POOIzyQ+jtfNALeW/4EVp613jBNaTQCUKwNhYCoh1YrMdheUoCg3vxP00bGz+m1Hb9RfWwIUU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR17MB6213

On Wed, Mar 27, 2024 at 03:53:39PM -0700, Yuanchu Xie wrote:
> On Wed, Mar 27, 2024 at 2:44 PM Gregory Price
> <gregory.price@memverge.com> wrote:
> >
> > Please note that this proposed interface (move_phys_pages) is very
> > unlikely to be received upstream due to side channel concerns. Instead,
> > it's more likely that the tiering component will expose a "promote X
> > pages from tier A to tier B", and the kernel component would then
> > use/consume hotness information to determine which pages to promote.
> 
> I see that mm/memory-tiers.c only has support for demotion. What kind
> of hotness information do devices typically provide? The OCP proposal
> is not very specific about this.
> A list of hot pages with configurable threshold?
> Access frequency for all pages at configured granularity?
> Is there a way to tell which NUMA node is accessing them, for page promotion?

(caveat: i'm not a memory-tiers maintainer, you may want to poke at them
directly for more information, this is simply spitballing an idea)

I don't know of any public proposals of explicit hotness information
provided by hardware yet, just the general proposal.

For the sake of simplicity, I would make the assumption that you have
the least information possible - a simple list of "hot addresses" in
Host Physcal Address format.

I.e. there's some driver function that amounts to:

uint32_t device_get_hot_addresses(uint64_t *addresses, uint32_t buf_max);

Where the return value is number of addresses the device returned, and
the buf_max is the number of addresses that can be read.

Drives providing this functionality would then register this as a
callback when its memory becomes a member of some numa node.


Re: source node -
Devices have no real way of determining upstream source information.

> >
> > (Just as one example, there are many more realistic designs)
> >
> > So if there is a way to expose workingset data to the mm/memory_tiers.c
> > component instead of via sysfs/cgroup - that is preferable.
> 
> Appreciate the feedback. The data in its current form might be useful
> to inform demotion decisions, but for promotion, are you aware of any
> recent developments? I would like to encode hotness as workingset data
> as well.

There were some recent patches to DAMON about promotion/demotion.  You
might look there.

~Gregory

