Return-Path: <linux-kselftest+bounces-11824-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D410290619F
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jun 2024 04:12:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59B992840AF
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jun 2024 02:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A287B17C72;
	Thu, 13 Jun 2024 02:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="P2n1GmNt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2047.outbound.protection.outlook.com [40.107.94.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC347F9;
	Thu, 13 Jun 2024 02:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718244717; cv=fail; b=aaFkJizONHcobXPe2BCaYAWUdAU68gniWTWpjI4PDLwV07OSEUG2gR4Lgb3wYWglcxqDDlYvzb47IdQY6gEpUVPDJLvzvx/m6ZalUsApez+Yv/lAfCSHQFg0j/bLFbNQxaNVoBCUuTrnXRL2LN+IFkmbM72qHD/lHbSlJ63vMic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718244717; c=relaxed/simple;
	bh=hOWGP/YtN34DdqEziNk8skVzpvrMlBRqbkDk2u/qkjE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JKmVy4uXan507c41EBCRkURa4+35bpOFgH0myi8ingaAdqgSg836VMYqz4+Zw7zMK+50IRFq8egWaMqX7qnKiungsuKZWENooVLFW80Rc+BEXVoaNEJdo8NZ0DsZmbU3n89hPlES+LYXv726cL3FuzoqIUyWlZPcS6US/E+tle8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=P2n1GmNt; arc=fail smtp.client-ip=40.107.94.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jERHa4Eo7weZr7juwHueuSYF0VS9jEq93W3XdUh5MlvSyoll+AeCFZOsWnH2mbYreidSO7oLwFWbmpxeO5g8EfJoDMYlcSMMwt6tnTMgYHDS8DXuhuxtKGIGqHRx0PxQ5W5JaqKQ87X6ufFc8y1lpc51MvETOKVyDree38tDoiEHKptqPDYtkNXbKbFuOkdNhstSiIFOHMIcADXIOWkR97iEI6ZrLAhAXBQkezcBQPKzG722jmzO8tSX+Ot1uKPJvP/xOBGo1RJtfldfoC+9hLwzgpWn93bjewkXMD9ugWZ9HjKGYTMXz/PlkntFrdu/6WOs+is6ylJmNelmLmB5SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G219uG58UJcqskMhUIteD7J/Px01LKIo9N2tv08rFzo=;
 b=G59Q3PvSNW0Xlh8t8T5miT9U2Nir/IJfpVKyvg7SEv/QfQNGYCNMUDWYYyszJrguJ/RA2AYM0lp+OHTbOGG8xtheHU+3n07OOn9nkxYlqDxb72Qvs+L8JFS0RgifwVMbrFP42P+KEoX0uSLSHqgjmPjApD3rPHN9jhB62v/nqTlS3UUXpdN0AoH34RwPR6qtff4FIFLs0zejck1Bep6d+QfgNMvlgpLz0U0XbVGdP76nqQsppMwfMkRBMo5k72yWD2gPwftXAXhKUQH4djIyPRB6RZjLEXeTZaSw+1O1CpXo+q6EJ3WbZ4Ek7OVhFIrByo9u69lKKBUF16Z7P7erYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G219uG58UJcqskMhUIteD7J/Px01LKIo9N2tv08rFzo=;
 b=P2n1GmNtnEUD1DtWtFQWCfmyR98NKUuhXYOPcfNwdNCFTC7fw1FSIfJIpgCR3ngC7J9myk8YhUA4qpiEgutJsk7nI2SYiVczIDJPSJL6ZNDl3i0lLJqj6PJrrBOBJl6VZei3VNr0P0gldUn2xvKAWt7xROI+mY+c1w2tElAgjNZwVpKaFRIw+jGCimDf40IJdnRmvq9mU8o2EifxwAtHou6uytxp1x6DoYwbmO9IFfDDWbSYg9wIPs021K81ja8sRUG0Lvm/l+elo0af6ATLhysm5RhFpYIMEX/7+MY9SMSRviKE8OdWT9vlP1+d4hQas44njWqXvGAlvQeMTPJGcw==
Received: from CH2PR05CA0035.namprd05.prod.outlook.com (2603:10b6:610::48) by
 MW6PR12MB8760.namprd12.prod.outlook.com (2603:10b6:303:23a::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.36; Thu, 13 Jun 2024 02:11:53 +0000
Received: from DS3PEPF000099DE.namprd04.prod.outlook.com
 (2603:10b6:610:0:cafe::20) by CH2PR05CA0035.outlook.office365.com
 (2603:10b6:610::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.20 via Frontend
 Transport; Thu, 13 Jun 2024 02:11:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS3PEPF000099DE.mail.protection.outlook.com (10.167.17.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Thu, 13 Jun 2024 02:11:52 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 12 Jun
 2024 19:11:35 -0700
Received: from [10.110.48.28] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 12 Jun
 2024 19:11:35 -0700
Message-ID: <b60c8c02-5497-4c6c-ae60-86309e55f1bd@nvidia.com>
Date: Wed, 12 Jun 2024 19:11:35 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] cleanups, fixes, and progress towards avoiding "make
 headers"
To: David Hildenbrand <david@redhat.com>, Andrew Morton
	<akpm@linux-foundation.org>, Jeff Xu <jeffxu@chromium.org>, Shuah Khan
	<shuah@kernel.org>
CC: Andrei Vagin <avagin@google.com>, Axel Rasmussen
	<axelrasmussen@google.com>, Christian Brauner <brauner@kernel.org>, Kees Cook
	<kees@kernel.org>, Kent Overstreet <kent.overstreet@linux.dev>, "Liam R .
 Howlett" <Liam.Howlett@oracle.com>, Muhammad Usama Anjum
	<usama.anjum@collabora.com>, Peter Xu <peterx@redhat.com>, Rich Felker
	<dalias@libc.org>, <linux-mm@kvack.org>, <linux-kselftest@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
References: <20240608021023.176027-1-jhubbard@nvidia.com>
 <b5dd99c7-866b-467c-9f76-d043e887394c@redhat.com>
 <c1277bf6-a211-49eb-80af-726f16ca1802@nvidia.com>
 <17b503f8-5d0c-48a3-9eeb-85b01583f9bb@redhat.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <17b503f8-5d0c-48a3-9eeb-85b01583f9bb@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DE:EE_|MW6PR12MB8760:EE_
X-MS-Office365-Filtering-Correlation-Id: 441bb366-378b-43cc-defd-08dc8b4e3111
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230034|376008|1800799018|82310400020|7416008|36860700007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RStGaXRzeHBBOHFmTVFLVDUraVJUb1NsVFJ0eDFOTXpHeVk4Q0lZdTFCd3ZI?=
 =?utf-8?B?eVdlMWQzVk9obEFheVhtM004eklDbXBoVWhGWmpFWVE0QkdCMXlUMGhJNjNC?=
 =?utf-8?B?NFBLbjdLeU10N1daaHJHT2ZsR0xBMHFJUVU5TjcyZE0veUZ6RTRIbko0c0py?=
 =?utf-8?B?TUhSdXU3akM3WkM2RHlyZzVMTTIvdG51VmJiNVVFSnJtZ29EUzgyZms2S0p1?=
 =?utf-8?B?NGhQTXdILzQ2R2tqdUlJWjd5c1pWamRZVTkrR2l6S3U3SUpwdy9yaFhzcFpq?=
 =?utf-8?B?dXR6aWtlSFdQMzhUdmZiUUZxUTNqRlR3TmRWbW9MSFBvWnVQWW5IbEh3WXZH?=
 =?utf-8?B?VytVb1QrTHRBZkg2QWdkOTNxNjRIRU9tRmpGTHBNalNkTWgvUGYvSXN5Ujcy?=
 =?utf-8?B?Wm9ic2RiUTkyRFpQM2dheGNoa2lKV2JubEFyajk0OFhTYm5lRW5ZRHJkamVh?=
 =?utf-8?B?VTdPSUJqYzIyN2lrMllYU0JzZExLY0JIV2RHSkxvMDNNcjE2VXR2YmwzYjc2?=
 =?utf-8?B?OG1HM05WRmppc3E4bVUxUVFTQzlVWHN1a1FHcUxkQWxrYlV2RDYwOVJ6OW8x?=
 =?utf-8?B?Vms0TGxnZ3JmektJOUY0K0JaSmFwZW1GWGFQMUlQMXhGcjZacUZWUFk3cm5Q?=
 =?utf-8?B?K3RURkFhRDd2NllDZ2RhcEZ3S2FKSFhDV1p2WEpxelI1aGNlUzY1aVhBRWFI?=
 =?utf-8?B?bDVzL2JlWU5FZC9VaEliQjZzMi9XY2x0WXZzV3d0OUwwN3ZKZUg0dWd5SXJZ?=
 =?utf-8?B?dERKdTg3VVhxS21YV0RMYmFzeWlaQTdiSkFKcGczcjcyK2NkVjExK2tNNmN6?=
 =?utf-8?B?MU5HV2VLRWRpOHJzcWk2WmdrVnVwNXJLUlhDaUV2M0ZucEdYOERVWWVCN1Zj?=
 =?utf-8?B?NDJTYktYWW5acDBrS1pUT3d6eklpQUdBa013RVZ6NVdmdHc2RllpTGd3R3lK?=
 =?utf-8?B?MUJ0Q1EvTFkvWktNRXlRdUlqbHUzM3VCY09Rc0x4T3FWU0duejdudlBwam16?=
 =?utf-8?B?dURubWJ6ZU9mMDV3Z1lUb2htdU1Yck1CVnp1SVNzRDlsbmRPTzZoSDN1U1dF?=
 =?utf-8?B?UUh5SUsybFlvYlpxQi9vTTl0N1pZRnFpZUpRTkNmVFJKWXFWd1psenkrSllE?=
 =?utf-8?B?Sm5qQ3k2b0FMWFJ6SHBOcWtOY1FsUlAzNStpcDBxdXN5NGJvcjBlZ2dqZldO?=
 =?utf-8?B?VjdZTlBNY3kyQk1WRWh6N250NWtqY2pqZ1hkUkk1Z3lCckUzU1VuRENxTG5o?=
 =?utf-8?B?UWtSd2tZeVdlTS9zWEI0N0VnV1Vncm9uNUVUaC9XbVJQc1oybEVvVFNaQkFq?=
 =?utf-8?B?V0NrNUlRRXBXVVFZSVJYWklaenpmS2VXZ2FUN1VnMmhuaUphZ0trbGU4azZy?=
 =?utf-8?B?OEtjUTNTMlNXaWF2TlZCeUVmN25QTWFwekw3WVhLeXhGSWxEMjkvaXlITGVp?=
 =?utf-8?B?S01oQXMvd2VwQjJXOWU0T3hEUkRXWHZoTUIyZzRxV2hpZCtHaW9pZnFxU1ht?=
 =?utf-8?B?K3lQaUZIcVpqTXUyMUhFMzVwL2IxYXg0blFkUmFjb2dlNUpJMFJzRk9rSmZp?=
 =?utf-8?B?eURCaFNwRWlSS2FhNDU2ZmFKSGtuVlFXTjhwTm1jbktOQlhzWkxnTU1SZDZR?=
 =?utf-8?B?SVd6U1RPbXdwQWpHdnpvVzhHOVJ3aG9PbXhxUlJnL1lqQmRlMXhtdEd3RDhO?=
 =?utf-8?B?ZDl4ZHU2SzhTbmRneGt3OVJMNHByR0k3QU9Hc0ZjZ3hvWEYxQmpzUmcyd3ZU?=
 =?utf-8?B?NnhPT2pRZHp3MlVxc016MGlPL0JrbDVxTTZPaE1rWnl5T3J2YzUrRmNPN1hD?=
 =?utf-8?B?N0RRMW5lQ0tFVnp5enZETllvRG5INzhQdU5iUmQxTjhRRHBvRUw5QXpqUXJL?=
 =?utf-8?B?ckZCei9LNnZ6R2g4c1FuUitxdGFaYXdYTllYWXhHZWlTcEE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230034)(376008)(1800799018)(82310400020)(7416008)(36860700007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 02:11:52.5326
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 441bb366-378b-43cc-defd-08dc8b4e3111
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8760

On 6/12/24 1:24 AM, David Hildenbrand wrote:
> On 11.06.24 22:54, John Hubbard wrote:
>> On 6/11/24 2:36 AM, David Hildenbrand wrote:
>>> On 08.06.24 04:10, John Hubbard wrote:
>>>> Eventually, once the build succeeds on a sufficiently old distro, the
>>>> idea is to delete $(KHDR_INCLUDES) from the selftests/mm build, and then
>>>> after that, from selftests/lib.mk and all of the other selftest builds.
>>>>
>>>> For now, this series merely achieves a clean build of selftests/mm on a
>>>> not-so-old distro: Ubuntu 23.04:
>>>
>>> Wasn't the plan to rely on the tools/include headers, and pull in there whatever we need?
>>
>> Yes, it is. You are correct.
>>
>>>
>>>>
>>>> 1. Add __NR_mseal.
>>>>
>>>
>>> For example, making sure that tools/include/uapi/asm-generic/unistd.h is updated to contain __NR_mseal?
>>
>> Well, here it gets less clear cut, because the selftests pull in *lots* of
>> system headers. In this case /usr/include/unistd.h gets pulled in. If we
>> force tools/include/uapi/asm-generic/unistd.h to be included, then we'll
>> get many many warnings of redefinitions of __NR_* items.
> 
> I think, there is a difference between unistd.h and linux/unistd.h. We want to continue including unistd.h from the distro, but might want to stop including the linux one from the distro.
> 
> My thinking was that we start maintaining our own linux headers copy in-tree, and start converting our tests from including <linux/> supplied by the distro to include the in-tree ones.
> 
> For mseal_test.c, that might mean stopping including "linux/mman.h", and instead including the in-tree one.

Yes. Something like that.

$ find /usr -name 'unistd*.h'  | wc -l
14
$ find /kernel_work/linux-github/ -name 'unistd*.h'  | wc -l
54

heh. :)

> 
>>
>> So what's really going on here is that we have this uneasy mix of system
>> headers from the test machine, and newer versions of some of those headers
>> in the kernel tree. And some of those are easier to combine with system
>> headers, than others. unistd.h is clearly not going quietly, which is
>> why, I believe, the "#ifndef __NR_* " approach has flowered in the
>> selftests.
> 
> Right, these mixtures are not what we want I think. But I have no idea how easy it would be to convert individual tests.
> 
> Maybe all it takes is updating the in-tree headers and then including "TBD/linux/whatever.h" instead of <linux/whatever.h>
> 
> In QEMU, we maintain some (not all) kernel headers ourselves, and include them via
> 
> "standard-headers/linux/whatever.h"

Let me look into it. Maybe it's fairly simple, we shall see.

> 
>>
>>>
>>> ... to avoid hand-crafted defines we have to maintain for selftests.
>>>
>>> But maybe I am remembering something outdated.
>>>
>>
>> You remembered correctly, but the situation is slighly muddier than
>> one would prefer. :)
> 
> 
> Absolutely, and I appreciate that you are trying to improve the situation.
> 

I think the attempts to further tease apart the include headers could
go into a separate, subsequent series, yes? And let this one go in
unmolested for now?


thanks,
-- 
John Hubbard
NVIDIA


