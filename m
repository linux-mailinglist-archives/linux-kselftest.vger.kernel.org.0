Return-Path: <linux-kselftest+bounces-30100-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D155A7BB55
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Apr 2025 13:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55CDB178B17
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Apr 2025 11:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F0C1BEF87;
	Fri,  4 Apr 2025 11:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="A16iTW4o";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="sKOghB+A"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC232E62BD
	for <linux-kselftest@vger.kernel.org>; Fri,  4 Apr 2025 11:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743765030; cv=fail; b=OPazO4m1nZlEt5IWmzCzSgWowWsBiKqn6Qsxtk4xwNKJ/W7B3zy/ZJznCzvxlC/hJ9JZ4WqJCR7mlNM4f4kU/gPRei9HcGnCKCCkwQGPjK3gIpX3PDBgORwBpWduIwdvk7d5RswNZ/SrrfEfJFHi29aPXC2Pxu41kyGmwyTeZKc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743765030; c=relaxed/simple;
	bh=CEcGeiYBrhZB3VifMEsjWdi36WDAAYOyKsUVaPKOPTU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aiQ+K26rGM3Z9//iLs6wUgpIiByF7szGvwSts2Jkv7LcreXheTaHUGtdVmEIUwOrjV97ly1rEM6ruXb06RJI35yLv1GY7A9jI4fsCNg1jQ7p5yes9rzhuT+t0LDL5NiyHHNnqdUdZAG2n6h/u0XLzorxmhUewscd2T6HW+7gSas=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=A16iTW4o; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=sKOghB+A; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 533MpiFi014638;
	Fri, 4 Apr 2025 06:10:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=PUnwmCUVAQj0xE6VaCl0boc7+fNu4i8pCaEcQYXknfA=; b=
	A16iTW4oG1kJUgbP6+DHkLsYKoDIWSSRHSL+KBlcjVM7CFcrhRDvtTOK0MpxL8BC
	WjPsn8FmXdFtbXfAdwi4L2iaFQEZYc5X+pPbdVw/BvHHZT9M47c3wzIlu444LWB3
	dt1tqfN4VIKZ9v0Oks3lrzbv0uxwMdPnoUbEudBz07bUKQr+Q9mO3+pCA2wom/M2
	rSZbfMClV/7dLpOQ47AdG6e+SpYC5zh5LUInn4plMDXhgzb61O7O9/OnXwJRpvoB
	wYzsJfdd52Njs9JvgJNyy0d4MhbD9RMQd9QS+yT3X6FsFQSiPTXGr6NOPyFzCyNP
	ye9phvDoGSDcYxBqd2nUCw==
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 45s4y8kgug-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Apr 2025 06:10:21 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SUlr1Q+4HSq2AGmMS2Whyw790xQXabEVtc7l+b8Q5Rn88X3l+EUXyptn5yzLI/8dlMTdK3tEoCJgGroY7FqZ3X6HI/2woINlFdjDAgrrnZVWSmAjzuSIjz+5d52CNkXauLFB4Y3zA0A2XTUfQahVgTRju4bTKvuE7Kqiug63RhPL7Y2D2a2p5XG/fFGprAKYND7EaiDge55B5vNvsHWT48Lo0YYJffFRKWQtlp/QW+m9WIhu4buv9zaqH6L3RNPpyscLBORacjeTU683WkEJ8dOru9i651h/q9QvGJ6I0XJ7KchjuHHBbthbR7HQ2Hvl7ydF5I5bwsHKQAsJXXBp1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PUnwmCUVAQj0xE6VaCl0boc7+fNu4i8pCaEcQYXknfA=;
 b=ig/SJnwcMiOEvSZJi5drtCqFZWFJouhFMhKZmg2p3B6xqPrctm5GeszeZ8SG+h4LxBsDu73bmBNMyEi8xyW51gNL/IyyQwfBWcY2S6GUSav8uho1T0URycBhqOkJNrPBJ6O2W35jZbkOdbqVl0DfRarC2z9GXVLdpsdeVpYefADiDEDNvqLQaEr2QCLDbN4H7ObbdrdFhB/IarZ+87vPgX4vN+fcAGnmfwbjWSAVd6HOwjWiiruWg4+cL0iycPZB7M46VWZY06kEfINYptYwzLtoVYEYsl4ZhlXZQOI5i1mjc22h02KavKc3XzWpPB8bMkIApvqCrhxcXKuOySa58g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com smtp.mailfrom=cirrus.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=opensource.cirrus.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PUnwmCUVAQj0xE6VaCl0boc7+fNu4i8pCaEcQYXknfA=;
 b=sKOghB+ACh5ydyGH1LqUNTjKm/X2gfDm83HhuvEfjxK61aUduDb2JgOrwsNJ4DlfSe8IFYfBcTkP3WzNablJu1HQcyq2NBr7KdVqnpOgwMHpO4uj/RIlI9nJ1/XydoFmtZ0FK07EnmNbfw/vQy3c3919hrZygHGUQYkvAn+J4fg=
Received: from MN2PR16CA0002.namprd16.prod.outlook.com (2603:10b6:208:134::15)
 by MW5PR19MB5556.namprd19.prod.outlook.com (2603:10b6:303:19e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.41; Fri, 4 Apr
 2025 11:10:16 +0000
Received: from BL6PEPF0001AB50.namprd04.prod.outlook.com
 (2603:10b6:208:134:cafe::58) by MN2PR16CA0002.outlook.office365.com
 (2603:10b6:208:134::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8583.41 via Frontend Transport; Fri,
 4 Apr 2025 11:10:15 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of cirrus.com does not
 designate 84.19.233.75 as permitted sender) receiver=protection.outlook.com;
 client-ip=84.19.233.75; helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 BL6PEPF0001AB50.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.22
 via Frontend Transport; Fri, 4 Apr 2025 11:10:15 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id EE8D8406544;
	Fri,  4 Apr 2025 11:10:13 +0000 (UTC)
Received: from [198.61.68.186] (EDIN4L06LR3.ad.cirrus.com [198.61.68.186])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 910EA820244;
	Fri,  4 Apr 2025 11:10:13 +0000 (UTC)
Message-ID: <04117788-bd0e-40f0-a72e-27d821302cad@opensource.cirrus.com>
Date: Fri, 4 Apr 2025 12:10:13 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Exclude cirrus FW tests from KUNIT_ALL_TESTS
To: David Gow <davidgow@google.com>, Mark Brown <broonie@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, patches@opensource.cirrus.com,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org
References: <20250402103655.3e0c62d7@kernel.org>
 <a91811dd-6f86-4af1-8d91-02b990ef2fe3@sirena.org.uk>
 <CABVgOSmSU=i9WvUHFERY--Pgqg3Hr_LxgA9HJ_5aG4F-FgKhzA@mail.gmail.com>
 <d9d9fa47-c926-4479-a0c9-fb6c0713b244@sirena.org.uk>
 <40aae10e-184a-446f-b4fa-09935e25ee21@opensource.cirrus.com>
 <8f2de668-0ee2-4c8f-a26a-1aa77f6a0108@sirena.org.uk>
 <CABVgOSmmU4gcRL=4XPp9+CuA8bhJonv=-CXY7gdQc45LDi7Qpg@mail.gmail.com>
Content-Language: en-US
From: Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <CABVgOSmmU4gcRL=4XPp9+CuA8bhJonv=-CXY7gdQc45LDi7Qpg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB50:EE_|MW5PR19MB5556:EE_
X-MS-Office365-Filtering-Correlation-Id: 19c57c09-8c70-473b-8498-08dd736946ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|61400799027|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Nk04VlliRmVaOEFMQ0tHY3o4MmFpVHpFVXpNNE95dEJpRUg0ZnJGOE84dSs3?=
 =?utf-8?B?U1kwN2d2M1VKblhhZ09VLzVTRHczMk9jckVkaFk4ZnEyVmtLUXp2RHVXeUNt?=
 =?utf-8?B?QXVTYndaT2tYVEF2bG9ZNHY0ZzRqQWdqOUNwcXhHdGkzTTlQWWxBKzZ0VkxW?=
 =?utf-8?B?enMwM0NuRmFoQVozOXdid0RSREVzTUNSTW80Zk5jT2ViaVM2TTFVam9ZUTJi?=
 =?utf-8?B?L3ZDYTdGMDNaaTVIZkU1S0RzL3pRSHVJOUN6VEdBM3RXb0MxK21rQXAyam1B?=
 =?utf-8?B?dHdIdnc2Q3lFMXNPcytQdGd3MGFpZkJwTk5kLzF1V01MbHZIWE0xcC94QXNE?=
 =?utf-8?B?Rmx2Z0t5Y2pVaS9MQkYwUXU5OS9HcnZhS1l4K1lRWGlSSGU5T1A0T1JVeG5O?=
 =?utf-8?B?QVk3cFZHMlFkQjgxcVNvTmczcEJxcjFETUo4UWlqeFV0VHRHT0NkNnZEcU1J?=
 =?utf-8?B?eVIvaUZBSXFIc2tremNQZTYrVlJOT1NMY0FlUW5GUTFtK21EbUsyWU9KTENV?=
 =?utf-8?B?SGNWQ25iRU1ueEdwYlBEVld2c3NBY01xdFVQWW9wclg0ZVhKUDFQTldxRHo4?=
 =?utf-8?B?SXBPblpYQk83bUcwMEFqdGF3eWRPRUFqbU8wcHI3cmQ4SmZjeHNHSUYzR0N6?=
 =?utf-8?B?QStPenAwUDZ1TTQ5K1VTSnlRaWtmSzVIZFB1SURueno4bzg5Tzlzd0xaeWt5?=
 =?utf-8?B?RWdzRUJma2xBeTBTVWtwWDNWY1Fnd3RhemN0TEFCTnAwRGNsNURvL0FGVi9x?=
 =?utf-8?B?UGRkNTZ3eFhrSkIvVElTRGs4MkZadEZyVURJemxSb3JlamxXeVNncDFFTlh6?=
 =?utf-8?B?YkdjSmplNHJpQVI3b2tDbXo1a3FlbC84MGZzNEk0K1FmSHp3bHBjQnQwV0E1?=
 =?utf-8?B?TEVrT1JKdlA4RTY2VmNuOWtmejhsbjZzV1czMUFOVFY5a00wd3U1MEtTZmU2?=
 =?utf-8?B?ZXpZVlFWK0xHRi9DQjBuak9FT20rRUhUc0hRM1o2dUhoZEtpalg5ZVhLWTk4?=
 =?utf-8?B?MTR4djlYQmpGVGM1Z2JUWGs4akJ5SGZKUzBqVGdjL0VOWUhVZDRTUmdXTWVF?=
 =?utf-8?B?bGhVQWEzOUJ6anY2U0dFY2t6aVAvaElaL0tYWWdHY0hMOXJXcG9KWXVVOERQ?=
 =?utf-8?B?YkN5cGpia3pvazFFWXIyWUZ6U1VBMk9NNi8rTXQ3T3poa29sZER4ZnFoZnFS?=
 =?utf-8?B?WkFTWFJRWVUxaU9rVFdkUlVqdkcwaTR1WE5ndlZIWEhLRkJKK2FmK3diUzla?=
 =?utf-8?B?NHZVdHoySEdXdVVvblJxRUtsZW85Z0ZxVjRaSFU1bDJFQ1c1dDZvQlBocys3?=
 =?utf-8?B?bXhEeWNtdndJNE5hUWN4cCs3Myt5OW0weHkyMmVsWG1RWEpqTXFzOE9yVTd3?=
 =?utf-8?B?N24rK0lkUEIxNkVxbk5LejdlUWgxaUhEY2xhamxVaGE5SmV6azR5TTg1UDVq?=
 =?utf-8?B?eVA1YTlRQjZUZDIzTzd1SUJnZFdyNlM5NHQzNDVGR09heERqUm5ydDZnazRv?=
 =?utf-8?B?eVNiUlF4VGZWNC9PTzRTMTFsRmFtd2Y5TThNbk9GUEVlaEFoanJmenhSN2FM?=
 =?utf-8?B?MlM5QUhSOStsT1BNZHB5czQ2ZkR4VHNzUE1lS2pLZGlLTmVQSjQzVFFuY3Z6?=
 =?utf-8?B?UWl2L05aNmZNa2xHbXF1Wml4eGtBQk5qMDNCKzQ2UTdVRTNSRlBqMXhzRlRt?=
 =?utf-8?B?bVhPa0hWaklTVmRvTmF2cHJjUlFWNUpwa29abTZLVC9CckIvUmtPUlhHVFNr?=
 =?utf-8?B?bmNLYzdXUEJ5a2NJa1Uyc0xBTTNFK01SZ1M2VVBaZU5aV3J2YUQxdW9KOHFK?=
 =?utf-8?B?RmtUcUExRm9aQUlkVFJvNGd3NVF1a1IxV1FwZmNzeE5wZk95TnZqeVEwbVVn?=
 =?utf-8?B?ZHZrTnlWalZlSy81aG5idTRCQ1NIc21HTE9iS204UnMzUTlSNllVZUJRZnpx?=
 =?utf-8?B?KzhrajBHdm1WTlRpWFVEOU9PVmdyUC9wb2xsLzh2VEFEd2FuOWNkV3BsUm9G?=
 =?utf-8?Q?9ehf/ZlOfxuY2L6NdP5JVPaZN4xyWU=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(61400799027)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2025 11:10:15.0990
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19c57c09-8c70-473b-8498-08dd736946ce
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB50.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR19MB5556
X-Proofpoint-ORIG-GUID: iPQX6hYlsJaeRIOJyBjIirw07z9dWcSx
X-Authority-Analysis: v=2.4 cv=bo1MBFai c=1 sm=1 tr=0 ts=67efbe1d cx=c_pps a=kqCqMoaEgQjRYYKBKtAp1Q==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10
 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10 a=VwQbUJbxAAAA:8 a=ePLxCqtrkTwXkmYcy54A:9 a=QEXdDO2ut3YA:10 a=BGLuxUZjE2igh1l4FkT-:22
X-Proofpoint-GUID: iPQX6hYlsJaeRIOJyBjIirw07z9dWcSx
X-Proofpoint-Spam-Reason: safe

On 4/4/25 07:53, David Gow wrote:
> On Fri, 4 Apr 2025 at 01:48, Mark Brown <broonie@kernel.org> wrote:
>>
>> On Thu, Apr 03, 2025 at 05:57:51PM +0100, Richard Fitzgerald wrote:
>>> On 3/4/25 14:26, Mark Brown wrote:
>>
>>>> I've not heard anyone mention hitting the timeouts, though now I run
>>>> interactively I do see that the Cirrus stuff is a good proportion of the
>>>> runtime for --alltests.  We could potentially add a config option,
>>>> though it'd need to end up in the config file so it gets turned on and
>>>> we'd still run into any timeout issues.  There's a tension with people
>>>> expecting --alltests to actually run all the tests as well...
>>
>>> I don't want to get into the situation where nobody outside of Cirrus
>>> is running the tests. One of the main points of converting our tests to
>>> kunit was the hope that more people would run them on more
>>> configurations.
> 
> Yeah, I definitely agree that this should be enabled by --alltests
> regardless: we possibly need to adjust the default timeout for
> --alltests compared to without --alltests.
> 
> Ultimately, this is about balancing a few different usecases:
> - I want to check nothing relevant to my config is broken (enable
> CONFIG_KUNIT_ALL_TESTS on top of the existing config)
> - I want to test everything I can in my tree / CI system / etc (run
> with --alltests, possibly several times across different
> architectures, or with KASAN, etc)
> - I'm developing something specific, and want to run all of the tests
> related to that (use a subsystem/driver/feature specific .kunitconfig)
> - I want to quickly check if my source tree builds, boots, and is
> vaguely sane (run the "default" set of tests)

I don't mind reorganizing the cs_dsp test into smoke and thorough.

Although the feedback I've seen (such as it is) is not about the
time it takes but the fact it flagged an error. "This test fails -
disable it" isn't helped if it's the quick smoke test which failed.

It's reasonable that people are annoyed if the test fails because of
a bug in the test. It seems strange to disable the test because it
fails on a real bug in the code it is testing (which it did).

> - I want to run tests on my ancient/slow machine/emulator without
> waiting all day (run whichever config makes sense, but filtering out
> "slow" tests).
> 
> Now, my gut feeling is that we definitely want to run all of these
> tests for the --alltests case, and also for the "developing the Cirrus
> Logic driver" case, but that only a subset of them need to run in the
> "does my tree look vaguely sane" case, and there's limited (but not
> zero) use in running them in the "I'm testing my config which doesn't
> have any of the Cirrus Logic drivers enabled" case.
> 
> If that's the case, I think the ideal solution is to:
> - Make sure these tests don't automatically enable themselves if no
> driver which depends on the firmware loader is enabled. (e.g. make it
> depend on the library, rather than selecting it. If there's an extra
> "dummy" option which force-enables it, that's fine, but that shouldn't
> be enabled if KUNIT_ALL_TESTS is)

I thought someone had already patched that but apparently not.
I'm not the only person who thought "ALL_TESTS" meant "all tests", not
"some tests". Given that ALL_TESTS is badly named and really means
"All tests for modules that are already selected" then it should only
build if cs_dsp is specifically selected.

However the users of cs_dsp can have a lot of dependencies that are
entirely irrelevant to cs_dsp and so cs_dsp *could* be tested without
those. (This also applies to other Cirrus KUnit tests.) I started on
some patches to make the Kconfig for the tested libraries visible if
CONFIG_KUNIT is enabled so that they can be selected for testing without
the need to enable a large bunch of other frameworks just to be able to
enable a user of the library. They are somewhere in my to-do pile.

Related to this I created a UM kunit.py config specifically to run all
Cirrus KUnit tests with minimum other clutter. But does that mean nobody
outside Cirrus will run it? Or is there a process somewhere that runs
kunit.py on all configs in tools/testing/kunit/configs ?

> - As a result, make them more explicitly enabled with --alltests, and
> probably disabled -- or only run a subset -- in the default. Currently
> this is mostly decided by whether CONFIG_REGMAP is enabled, having a
> specific item to use for these tests would be less surprising.
> - If any of the individual tests are particularly slow (more than a
> ~second or so on fast hardware), mark them as slow. Most people still
> enable slow tests, so they'll still get run most of the time, but they
> can be skipped on old m68k machines, or gated behind the quick tests
> passing in CI systems, etc)

I don't expect any individual test cases are slow (I'll check through).
One of the advantages of parameterizing them was that it avoids one
single test case taking a long time looping through a lot of testing.
They should be a quick write-read-check-exit. "Slowness" is tricky to
judge. The slowest hardware I have is an ARM7 clocked at a few hundred
MHz, or use QEMU in full emulation.

> - Bump up the default timeout ( at least for --alltests), as 5 minutes
> clearly isn't enough for, e.g., qemu-based emulation anymore. (I'm
> happy to do this: I've got some timeout-related patches I'm working on
> anyway.)
> 
Is this a default for each test case or the entire suite?

> Does that seem like a sensible approach?
> 
> Cheers,
> -- David


