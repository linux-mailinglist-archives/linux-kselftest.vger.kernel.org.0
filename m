Return-Path: <linux-kselftest+bounces-10932-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8DC78D4F9C
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 May 2024 18:08:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F7F11F2172C
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 May 2024 16:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F15CA20B12;
	Thu, 30 May 2024 16:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="By+y7Kdt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BF8210E4;
	Thu, 30 May 2024 16:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717085291; cv=fail; b=QDLjY7kC9+stLFRU7fK3q+99ShYMR0EbNGCVcGgD73r+m/n/YYCnGGwLnG8TR28hqjgP+dh9PNqhUkI4D1JsqpA1B9xxMdX2PwcbNGLycQha9tI/fieB3YJt9/ddY+Bk+z3j4m35IhbAhVPYDe8bKYBiebjHLo8OyYKw/TUdtes=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717085291; c=relaxed/simple;
	bh=tjxbikDbSjChhfb30mhNOF1plp82KzyQ8zfIXhlNc3Q=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=o6sIkRNZQFeFrbnzXikL/N95RGwtl0ItseLCCq2RoREsTCt7PIQ+FY6Ue8nm1kAKk6ZOogm8qOD2QU4pLDGV67thxcp1kvXZUcbpQkCtA4NGSnEr7E/pTH/AILah208EH7ivKLsh8WYbY93ELlrA07ZpvJRq94JG/bV1Dd9jG98=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=By+y7Kdt; arc=fail smtp.client-ip=40.107.237.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d4HZLVOFXo9vttUdJByfPDtVe4ULdOotxPsAOuuFnb2uIh/vx16+21o8CliENh57PsqrlBY0wN1v17MvTfrtV+4r46swTWHlTbGi4+IdbZRPD9LWpoXpp98o4GGrZztD1oRv54bZHtuzouxRCq9iDONr51DaYLiFsobbRpd1hVzdjYOownlBYHpp4O/Q71JuE5ln7VHAJ1SbFUvM6GxT6JISyI8WWv0Fk5z/zjpTBAAOUjHI0i9zUq5WUy3k5PITx3D0CNF/yjwXM/UcnDnW8ZeqVOKlgtUsJqyzFpcg/w2XDPJdITfolNj0EzXAWJVlpxeIzHVagNNYGUmkix/dkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wViQjVLy0RFmgcR+0JECVRfvukquweV74j6qhGByt3g=;
 b=obdMYYYTNg/utQWScLUvWy4bRMsa96qWAAv4efuL8JxlM8NebU13mxVkOjAszhAPYZydh6uWOAgpZvaab3ArLUazvJwzWzgJV425ebWG25pzqsSgi2x1f3lxsU60+lDxlfOCKgEba2/GePJLCEYLuZitsTNxLqGCNvQO44MhaLHXbi4LX6m068N+zJRjsRB4bdx7CyeOqtQJIT95qyzV0qPf+Ogk/Nn7kvFKEGIis4Q3itlKcj6i6ddAnvKeGE5kUcMBavl5t2giwEb34y4eWCYyjknOjI9Ji6OZbi/8LJ8uMa0fMlyhR35jPnCVPyx3jGkqE94zN2NZCi5/29Xh4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wViQjVLy0RFmgcR+0JECVRfvukquweV74j6qhGByt3g=;
 b=By+y7Kdtrut9CiEDVug3wO8XAuPHFzHXMwUNaeZPfjH9t7vMrrgCFWqfaucCsMV4xiZJwkfBJJlmhex7KiuJuP903Kx9kQM7jD9Tr4o0mYDRuOiUTYVSnmFHvCM8V+zjZdg3guJD+tbrJStuXmyl4hq65t6fHTd5wcSaufg7ZLs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SN7PR12MB6930.namprd12.prod.outlook.com (2603:10b6:806:262::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Thu, 30 May
 2024 16:08:07 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%4]) with mapi id 15.20.7633.021; Thu, 30 May 2024
 16:08:07 +0000
Message-ID: <11449a50-c207-4cd6-875a-f2a5ffe8a6d9@amd.com>
Date: Thu, 30 May 2024 11:08:04 -0500
User-Agent: Mozilla Thunderbird
From: "Moger, Babu" <babu.moger@amd.com>
Subject: Re: [PATCH v2 2/4] selftests/resctrl: Pass sysfs controller name of
 the vendor
Reply-To: babu.moger@amd.com
To: Reinette Chatre <reinette.chatre@intel.com>, fenghua.yu@intel.com,
 shuah@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 ilpo.jarvinen@linux.intel.com, maciej.wieczor-retman@intel.com,
 peternewman@google.com, eranian@google.com
References: <cover.1708637563.git.babu.moger@amd.com>
 <cover.1714073751.git.babu.moger@amd.com>
 <406d1fbe6b480fbe13fd0b8c432cdc517a7bd8c1.1714073751.git.babu.moger@amd.com>
 <eb80df2b-d6ba-4171-ad05-c76c218b0e3a@intel.com>
Content-Language: en-US
In-Reply-To: <eb80df2b-d6ba-4171-ad05-c76c218b0e3a@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN1PR13CA0015.namprd13.prod.outlook.com
 (2603:10b6:408:e2::20) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|SN7PR12MB6930:EE_
X-MS-Office365-Filtering-Correlation-Id: c1f932bd-25d8-49dd-7170-08dc80c2b1cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VWkrWEtJU0ZYRmNFQ1dQMUg0MUZiR2dFUUhCUDRTLzc5Qk52cVlSQzNDRmM3?=
 =?utf-8?B?Q05nN3V6TDNtSm4vN01kN3JxWHg2amk0dG1IQ3dDVXM2NUk3bGlkWE4zSlBt?=
 =?utf-8?B?c2xacFFSVWo0L21Dd3creldaVDU0VnpKbXY3dFR1d2VDbWNLWC90TWxZSFlK?=
 =?utf-8?B?RC9DeTlXWXRxYTBxTDYxQnNOdjd5NkZJeU5sWUZlV3NGL280WWdlalAxMXpX?=
 =?utf-8?B?dG1EdzNFN3ZsUFlZUDJoeDBnNlhlSjJndHRMQVBCWTR3VzJSd0lSVng5eTZS?=
 =?utf-8?B?MzBpNGNrZEJITG9CYjNuN0lVM1MxL1dVZmY1QW5sM1Evekg3Q2pSSi83Uy9C?=
 =?utf-8?B?bkpJNkY1V2t5dm8vZjFLR3FYNjNhZEpyeGlOQWNnSDAxWXNpdm1BT290WWhn?=
 =?utf-8?B?WnNQNEVzd3pBalZPNTM0dmV4M3dBVG5MTE9VbzBUaUxZR2lzK1Znb2RzMHY3?=
 =?utf-8?B?aHdPdWdJbFhDL1VFYzRUNTRCZnhia3NxcjRJSE9Ydld3UDljK0xwdmtrYlJs?=
 =?utf-8?B?QUVDZlpSVU9lVllXSHFmeXVWYmVWOUN0NkVML0xGckI3YVZjK3FIcEZqSlF2?=
 =?utf-8?B?dGpsL09ldC90cGNKa3A0SnIvWW1vbklSNFhtdXJ4bWFvMlFQMFd6UnUvNTZS?=
 =?utf-8?B?NisvcHIxQURRc2RjQWR1UWYzTGpjaVJLYjllUDJtYmZCWGh6TFpNanZRUmZE?=
 =?utf-8?B?ZjFrNjlocjVNRk43bGc4NnptMlpNY25odlVCUi9UVytQcXNhVFpnQXNkYng4?=
 =?utf-8?B?N0l3Z1VpUkFyeWxSSEVMY0d5RjREaXo0OTNQbk1MVXdVTzY4cUtSdyt2QndX?=
 =?utf-8?B?R1ByYUpuNmlWT2tFcHhrTEk1UXByaUkyTzViSEpIQzR4Q3Z3UEFaaUVTOUdK?=
 =?utf-8?B?L3U1dEJPR09EQm5TdVB4Ni9sMDNaOTFMdytFMjh1VTRHWmxGT3UwUGRIUXYy?=
 =?utf-8?B?THRzQXd3VzY4OHhSNm9mN1dNaXgxelorVWF5cUhWRGpiTHBsWktISDVrcXl4?=
 =?utf-8?B?SjFzQlJJQndlN3dhZUtGRVVIdTE5MmlUMjI2S0M2elVIR1V4OU1tYVh2cDVB?=
 =?utf-8?B?cHhWTlJqaGIwcHNBZmxWczNoRHFkSEpPZTBrZ0g2MG9lN3VISmlNODNpLzVW?=
 =?utf-8?B?VzVWSVF4MEtLY1pmbFdNd3pHbitMUGQrNHVYVW4vUXh4dHMyd3puL1dJN1Fa?=
 =?utf-8?B?UUYzNDVtU21KYzBlUTZoUWRKalQ1L09BcVNBYksyYVV3NGRJVXYzTkM1NXJs?=
 =?utf-8?B?TWpuOFY2dXcrNGpicGVZNmFDczFqeEtvQStJVnlZQzJjNlZEZmFGR3ZTTFZo?=
 =?utf-8?B?UWZXS0trT0VJMWlNYnhDSitPQ2k5THVsemloWjlWTGhsZy9XL0JadjZqUko4?=
 =?utf-8?B?YmFRTlV6dm9YSWlvdjJzd2JEQ3RORzQ4Vnl2UVFLcnlOMjNhQkhZZjdXVzZN?=
 =?utf-8?B?b2QyOFg0ckRQVXR0SjExVmYvaWdIT1pLVEdTbmNQL0pwUXVCaTczNjZHVWN3?=
 =?utf-8?B?ek9xKzM4RjlqSlNTUkVTNkZyQmRoSkZqNVorOHFlYnYyTGx4UXE2WHZUanc1?=
 =?utf-8?B?OWJGSHVxY0RyTi9PaWdiZWx5SCtqUTVYVmpjT1QwU1JpSXNoeUhxQ0h4ZUJB?=
 =?utf-8?B?TzJkNnlNSEQvek5nQUd5SjFDZExSQzdFcU9sSE4wMUxobjlReTM4K2pXdHdS?=
 =?utf-8?B?WlAwTE13a1diWGNIZVFadDBCTGtPUEg2bUJLaFJ4Z1NaLzZMcFZOQ3R3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dFRiMXh3UzdJTCtuclREeTFXVS95czVzVGpsYmg1TzUvSUpTQVVpQWpyNmxm?=
 =?utf-8?B?SjBndDhvMGtwNThka01razIrOG5KVzRoMlZaSENDUGRlb1U1N0V4UTBEYmdh?=
 =?utf-8?B?cWNOaGtHZmNPaWNubk0zQW1wUjN3TTduRXJjRGJiMDZHbmx5cVEwZHEwNFQr?=
 =?utf-8?B?a01HU3NBSzluWlBnVmVmTjZRYkhHWTRYc0lYM1NLWVhPc2sxd01POFJ3c0hC?=
 =?utf-8?B?Sy9kTDhCSUVzMVJSYzNMUDZ2YkdTdTYrajRuYXQ0ZkdaYlVoaERQbERFa1Vm?=
 =?utf-8?B?aUgyL0hGZmc1bVNUNlNlRW14a2RVOTh2enlZWUpyUFovTU0xTmdGY05rQnNv?=
 =?utf-8?B?a3lRV1RBeGNjTHJlbzE0a2pOWGxsNVBOemYwTnNNc0VvTUFIYVhHN25WWVgy?=
 =?utf-8?B?eng3dUhFZXd4a1BlNDBuUjJoNWlvRkMxSzlsQmhKVXkvU3NUd1g2MjJacm9m?=
 =?utf-8?B?ZkJVajlobkNzNE9mcUpZN0JncUY5Q3NMVXlncXFsMkxCeWFKT1JaZnRtREl4?=
 =?utf-8?B?MzgwU3d5cks4Q1h1TU5YOTdLNndtYTFqVkY5cVZ6VEppUG0wQk53VDRNdU4w?=
 =?utf-8?B?Q2trcEthYWpOa3ZHK1laOHBSeGZndzA1YlZXUU41MEdKL1hBTnNSOFY5aEhB?=
 =?utf-8?B?TDI5VExkVVNQMHBRTEVWTjlKbWtTQzdiVXJaNENaUzRBbUFTTFJmS003SlVD?=
 =?utf-8?B?ZjY0bVNCN2ptSGNlajVlWEFWNXZLY0xFcWRnQ3ppZyttS0hNMTZFWWczanVH?=
 =?utf-8?B?Y29LYnVhcmJEZStIVjVYSDZoa1ZKY2g5UjlITGlXNGlyVVFLZmpvK1FnOThq?=
 =?utf-8?B?MjI1ajFLZUxzLzVmZ0R3Sm5zYWFld2tlTWZBTEo3d0N5cm9EUGtTbGNEdm5H?=
 =?utf-8?B?cnB6QXJWNERDcnZPQjQ4QUdFMWtFUTRFcDNGUWJpL1ZrS0xQK3BGa0sxN2lQ?=
 =?utf-8?B?OWdMNkNGQ0cyWjN1bnJGZ2NURHJEUTFWMVRFNHNnSVhUMEozcVY1b2s3bVV5?=
 =?utf-8?B?M0NYaE1ueXl5UHB0dzA0TDUzOWNjK0VUTTVQbjlVamtVM05GVy95a3RmVW1h?=
 =?utf-8?B?emIxeFVGVExYMkZZS2RUVS82b295MitlS0V1OHVFVE1HUjJuc01oMTY2OUh2?=
 =?utf-8?B?UkFlT25IN0VlNUhDZVlHRFROTlpQeHVHUVd5clNOTDR5Yzljeml3TGQ1bW5F?=
 =?utf-8?B?RDhHRDFUQlkzMy8xOE5xalpoOU1sT3E4RXhtN2FEMGFyVFRwZ095Z0FoU09S?=
 =?utf-8?B?aEowaHZJOFhyckQ0Z1p1YWJWUkJIbDVlZWEwYWEwTEdQSUtsWUxTajA3ZFM3?=
 =?utf-8?B?VENnL0xsV05rZU5sZE4rbkNRTGI1UkFVOUZwNDc0bGJHQ3c5OGh6ZzRTenM3?=
 =?utf-8?B?dnVqZVByVW5OVU5EQzJnajk4RlVXY056ZFBGb1BQR0syVEpmTTRFcE51M3FU?=
 =?utf-8?B?cXlZQWE4emRRaG4wbUhsTjFQaFFyRlgrWVI4cE1JSjl4aDF3UjMwd05vMTBx?=
 =?utf-8?B?anJidEpTU2hhMFhhNnVMWmk2LzBVZnlXcDFOVTgxbUtFejMwSi9ZRmhIR3lm?=
 =?utf-8?B?NkVrVzRnSXdrcm5ZZjhVa0VHOEplN3hRSU4rMnNBbGJLYldibmRZZk5BZ2FD?=
 =?utf-8?B?M0xnb0NveGswaGVCU28vYlkrSFp6d1h3bUkvTWxmb2s1bG56Ym56REZNSUpj?=
 =?utf-8?B?WVBhZHpPWis3VVpTSTlkZndBbDQxRGEyS2tMRVJkM050bHpDK0JXNDRyQXBa?=
 =?utf-8?B?NFNqWnR2T0ZNTldON0E5bTdGclFaNUNBOWVGQkQzS3Q4Tm9icC9rT2RuWDAr?=
 =?utf-8?B?bG1wV08wNXU0dlBaU2s3czhUd0FRbUR0VmwvQWQ2ZCtleDF5U0JZSDlnRU5G?=
 =?utf-8?B?MkNUS1p1R0F6dmZ0bU1zWVZ2RWlNTnRmblc4WCtMb0lTVnlyQW1Ib2dwamov?=
 =?utf-8?B?ZVlYemYzUEJmbVNZN2Q0SHNtOHZKMHlQNEtPVnBiMWV5N1dSeXpYVEVVaStu?=
 =?utf-8?B?TWQ2RnlUWXkxQndxSTlQamtWK2dsWTRFVEdaT1JzemFEQXhvWXB0QVNsVWZr?=
 =?utf-8?B?b2g3TjRVL3VyT1BaQVFJdEkrUGNuLy9SeE1sWC9aYnE3a2JSd0hQcG5RTG5M?=
 =?utf-8?Q?eYK0=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1f932bd-25d8-49dd-7170-08dc80c2b1cc
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 16:08:07.6043
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1eAqOcAVaPzgxSff1EIWEXNQ9qRk71un4SCJbxzj9qYDr4hBsNH87xh4wTX73fg9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6930

Hi Reinette,

On 5/9/24 16:11, Reinette Chatre wrote:
> Hi Babu,
> 
> On 4/25/2024 1:17 PM, Babu Moger wrote:
>> Detect the vendor and pass the sysfs name for the vendor for searching
>> the controller information.
> 
> Could you please write a proper changelog?

Sure. Will do.

> 
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
>>  tools/testing/selftests/resctrl/resctrl_val.c | 16 +++++++++++++---
>>  1 file changed, 13 insertions(+), 3 deletions(-)
>>
>> diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
>> index a30cfcff605f..e3b09128ec3d 100644
>> --- a/tools/testing/selftests/resctrl/resctrl_val.c
>> +++ b/tools/testing/selftests/resctrl/resctrl_val.c
>> @@ -224,14 +224,24 @@ static int num_of_mem_controllers(void)
>>  {
>>  	char imc_dir[512], *temp;
>>  	unsigned int count = 0;
>> +	int ret, vendor, size;
>>  	struct dirent *ep;
>> -	int ret;
>> +	char *sysfs_name;
>>  	DIR *dp;
>>  
>> +	vendor = get_vendor();
>> +	if (vendor == ARCH_INTEL) {
>> +		sysfs_name = UNCORE_IMC;
>> +		size = sizeof(UNCORE_IMC);
> 
> Why is separate size needed? Can strlen() just be used when needed?

Yes.

> 
>> +	} else {
>> +		perror("Unsupported Vendor!\n");
> 
> ksft_perror()?
> 
> In the message, "Vendor" need not start with capital. It may also
> help to print the vendor value in this unlikely case.

ok. Sure.

> 
>> +		return -1;
>> +	}
>> +
>>  	dp = opendir(DYN_PMU_PATH);
>>  	if (dp) {
>>  		while ((ep = readdir(dp))) {
>> -			temp = strstr(ep->d_name, UNCORE_IMC);
>> +			temp = strstr(ep->d_name, sysfs_name);
>>  			if (!temp)
>>  				continue;
>>  
>> @@ -242,7 +252,7 @@ static int num_of_mem_controllers(void)
>>  			 * well and hence the last underscore character in
>>  			 * uncore_imc'_' need not be counted.
>>  			 */
>> -			temp = temp + sizeof(UNCORE_IMC);
>> +			temp = temp + size;
> 
> strlen()? (Keeping in mind the adjustment for the "_" character).

Sure.
> 
>>  
>>  			/*
>>  			 * Some directories under "DYN_PMU_PATH" could have
> 
> Reinette
> 

-- 
Thanks
Babu Moger

