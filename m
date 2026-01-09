Return-Path: <linux-kselftest+bounces-48632-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 834E1D0C493
	for <lists+linux-kselftest@lfdr.de>; Fri, 09 Jan 2026 22:20:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BD54130210E0
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Jan 2026 21:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3658033C50F;
	Fri,  9 Jan 2026 21:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tYmTwWHz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011051.outbound.protection.outlook.com [40.107.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA0519E97B;
	Fri,  9 Jan 2026 21:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767993635; cv=fail; b=XpRIzF3KVCbNZ0652c0utUWHEfToKgH0i/bPIuTnDg6Ekh2jG5wP0A/R3chRlLEskNR2kMHxfMnQBrCJjWl7okgG2KUPb41fCZcxkXo0BdtcQUsmwD7xeiIfvpCpl+Fjwqv9M5UKbNIS08tmi9nLCGAzaa6y0UAoT0htgfGceIc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767993635; c=relaxed/simple;
	bh=ahAlTLnO3zHFH3dDBW+B1wOU9Uykcqe7Gm4ug/ZNfDo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TOb/Ykh6qMXJ2VAcW3RwCJUzHQLFuI0HK9Roh0V+WFtRYkCJfrBmBKC2cqWUGRtuZeLtgW4gIUNaLD5oZdHO1JTQOVEhEOgB6C3//XqVZjHxJMMeR+V8FaUujAlO1cPxKYT3Gn/IcPfklbu2DcKlnihhNy6auAQ44r80tYJXHDU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tYmTwWHz; arc=fail smtp.client-ip=40.107.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u47ddquYN4hIWURLguo6QIPD/fyyR8wsNC1NV/Rxsj5dQtk8dj+fVunfAPaW3tGO6G4148+o6wP23ws/iLuP98M7iF1GH7X4DLp8tZtEHDp2Z+/QRKmSgGIhyo/AsSS/W0ZpUwBg8jfrxYiR1XBdSuwfYNsFClfzkGIosQRZD24G6Q2/7pOsoT3W6cwsLEDzzDKZOvyqOoqcigm6Qa+2DaGldkV2t3txHH/bt0fdcs1A5Gr7841AnpOV87dNLAlDBcx4uHllcFzMXjBj7QIUWLd0dSvMrvYwNecANoJVGQiA6GE4oq/gRu7Lct2KX/GZGQXINd7dz0ing6LntVtdpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v11jqvmwy8yJtQ/dzF+B19JF7EMla1yQU9javwgA9n0=;
 b=YpeiGz4nhRKh/J+0dv6ZWtwN/zLkqMv9mcR/Fb/hT8dqqos+/TWNcv88WtUKN6ocdzQnijCx7yngo6YyM/re6ez9zmJ44MefGfq9AsV2CBVxqzKds+8F0ejS6G/OzPpTxMd6a3TcYcjQR8VPrYU3cL8Jibw19Hdz/2/2NEPRA8zETwXZzVslhdc6wEJUCGBg6ydfsfhx8abmOv0U/UdiQkH00hutZAaO6MsJ2TkhJGjzM6mV4oeXQLENu3mYwPbn7iBBYaYM9VjE+PtbuTuw2Vx/dsS+yqPvMnjpx9xv5Mojv/po2cYulWXmxaiqpJqewCo/vSNq++D7yW/AGFypiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v11jqvmwy8yJtQ/dzF+B19JF7EMla1yQU9javwgA9n0=;
 b=tYmTwWHzVa3/vfV7e6uKMmHfjxP4bwi33GuTgK+lnKqjpE3JzgQnzAgzk+1Mu4oVDHje+M1WOndxAvhprXx8WF1/wi1AmJpJ2CZzKnvnX1Q14oGMsrURCElY+cbnQMHwmjubmABaq2kCEoMhzMTzaq1KZr0wKHNBEnpeLflbS1YTnoGy6TvXFqBpQqpCv4WI2NZkBlsoqQldOPqfUh85HqHyLG2iFauXOqGQsfHnDkVUDIRNwelYVgGfOF5XKgHMTptLHcJh/QelFs93tcjUo3n0aAh1NsLOKbDvjzn6XouoX8vFY4zTMnaLsRGLQucPaA9/I0IRjZ3HK4M9YCqC2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by CY8PR12MB7290.namprd12.prod.outlook.com (2603:10b6:930:55::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.4; Fri, 9 Jan
 2026 21:20:29 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%2]) with mapi id 15.20.9499.003; Fri, 9 Jan 2026
 21:20:28 +0000
Message-ID: <d1b547da-23b7-48c7-8566-56be4ef2cef0@nvidia.com>
Date: Fri, 9 Jan 2026 16:20:25 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next 4/8] rcu/nocb: Add warning if no rcuog wake up
 attempt happened during overload
To: Frederic Weisbecker <frederic@kernel.org>,
 Joel Fernandes <joel@joelfernandes.org>
Cc: "Paul E . McKenney" <paulmck@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>, rcu@vger.kernel.org,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Josh Triplett <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>,
 Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260101163417.1065705-1-joelagnelf@nvidia.com>
 <20260101163417.1065705-5-joelagnelf@nvidia.com>
 <aV_n5RqNbikyN90u@localhost.localdomain> <20260109034930.GA1105379@joelbox2>
 <aWEShKdoEAG0PiPM@localhost.localdomain>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <aWEShKdoEAG0PiPM@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR14CA0002.namprd14.prod.outlook.com
 (2603:10b6:208:23e::7) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|CY8PR12MB7290:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ac0c7a2-59e4-47f1-8fc9-08de4fc4e9c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NTJZVWlNUjF2azRVSnVGS1JUbmpGVUFzUVM1czNybjRxc005Um1ZVGg0M2VX?=
 =?utf-8?B?Y0F2dVVscEVHbFpyK0J5YUlpd0hvaWZkcjIrVDFmNlJtWEtUa1dXN3Jmd0VK?=
 =?utf-8?B?YVVWcDV5VjJIM2VlVG9hOHMxZlpzRENlVEdnNTUxVlZyWDlxYVdEUzBLRFpo?=
 =?utf-8?B?dGd3aE9KbitsMjF1ZUM3bzdiWkt5azQxTUZkWHZ1WFdCVmE1dlRSTXo1dzlF?=
 =?utf-8?B?dWNjaFFiUy95RlVKZUNKN3hRd05oR1VQWFdqMkl0Qk5CNWFuWGpudmtFMkdI?=
 =?utf-8?B?cTNKVlpSd3UwTnI2UlZJc2FTTC83R2lhNkRoUCtUZ1RoYjN1VUI4aTQ5TWI0?=
 =?utf-8?B?dy94OWF2SXNrVmlyMm1lb3dVV1ZlTUEvY3pBWDNsVDdZbzRJT215djhoMGtv?=
 =?utf-8?B?NFBIYkFiMFJ3bmdWN2VkK3VRZjc1S0U2RDFySERBMjNhTnVzQXdhcVBZZkFj?=
 =?utf-8?B?MWhLcnIyakh5UC9FSnpRYms1QjI2aXVNMlV0cnJXRWRQR0NWa0Y2SUdza0hx?=
 =?utf-8?B?VFlXMmdjVE5hZjhlYXpBcXM2VUM2V0JiRTQwNmFvNUpzcVFHOHlZRU4vbHk2?=
 =?utf-8?B?MnFqMDd6NFhwV3VoRmVDRHRBbWJ4NVpscGY5ZmI5NExvYjNaRzNkR2d3UXFH?=
 =?utf-8?B?NTFTNERQWVRlOVFlMklRSmlpVXFib3ZrdGt5QWxZY05oV04vS2NzVEQ4Nndw?=
 =?utf-8?B?ZVhXTVNVSTEybXVLWUdlMkYzUXVFVi9FK0xWQXg4M0dhTkVRbjVIbTlTK1l0?=
 =?utf-8?B?azRKWDNISFJqczhrU2xXVEpIaGZuVXRqQnRWbHk4b05EWDNyclQrQlZsZXA4?=
 =?utf-8?B?SnBlV29sZlROT0t3M3NWODU4WWZxWXp6SWRlbGxEZGlNSk85VEZ3b0JCKzI5?=
 =?utf-8?B?VXVEREdZaU1odTE5MGFPTlN5Y0w4Z0lzOXNNdFUxcGZhY0l0TUk2aitnZmZH?=
 =?utf-8?B?a2xDTHdjdytxREc4NHhRb2gzYytLWFNzOGNlN0JxSjBhUVl1TGlycHpId3k0?=
 =?utf-8?B?UUw1TUQ3N214MHkxcUpRVDZObjNHV0pablpxTFhkdklzOGV0T216UFZOL2dZ?=
 =?utf-8?B?NzlQV1JXbzZQKzQybDErNXNLUG1rTGRMQjNwSmpEVjJlZzZKdzN2cVhweE8x?=
 =?utf-8?B?S1llMFAwTW9qcGFyci9ETkJhMTJQdWZVNHlqc1R2bkVLQUVEanRaaGlxQzNI?=
 =?utf-8?B?QmNsWXFabllaOUNlRWdOU1l4UnZqTHVsNTdwb1RvOG1MNFlnYXQrdHl2aXVv?=
 =?utf-8?B?VHlrT2VQcjRPenB0bGl3eDBtTFE3MU5SRGs5NU5vcWgxWjdSZ1FsY2tXUUEx?=
 =?utf-8?B?VlVxNzVTdFJjZGZrOFVWZjVjejZ0TWl6SU5hU0wvdE1vbHI1dFMxbDRYbFlE?=
 =?utf-8?B?UVBLckRMS1pySnExODQrd25SREhMNHowck8zV0o2a1JyOTVGWS9pUEJyc3BE?=
 =?utf-8?B?NlpoMlEvbTU5bTBxYnBlTUJROWdJZitkWVR1NktMaG5WRmo0c3J6WUVDZzNM?=
 =?utf-8?B?WSsra2dZT0ZoS2cyNUdFUEFSNHpMWlNZSTJqaldlYjNTY3lOaHB1WmkrOGlh?=
 =?utf-8?B?MmdtNmZJMkxsWDRzQmNaN210OEJTcFhsZjg5SmpMUTdVRkkyK1RlR0NaY0dD?=
 =?utf-8?B?YXBFQVNrNVVyc2FONStOcGdMMXpFdjRqbGRhcEtncGJITzdDWnlyM29QWG9B?=
 =?utf-8?B?ZDhSTDdpS3pjUm5SSHdXck5hMGpYSEpWWnZMemwzdVpPRUk1MC9LMVBybVpJ?=
 =?utf-8?B?bUVuR0Z5MnpXekRHTXB2UHgwQ01YYVpXRC9VM1ZZS3prQnR5TE5BdzdtUnRQ?=
 =?utf-8?B?NHZnWVNSRnQ1SmkrMmpDcWN5YlBYckVoVlVMWXVXMzd3V1ByZURId280QUJm?=
 =?utf-8?B?TUlWUElxWDVyeEgrdWZOdjlIZmFiVWFUbEovSGZob0hUWjNnRlZtMGJqcjQy?=
 =?utf-8?Q?RlK82aLO07uiiagh9E1CZLd7wDlWRYLW?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aVNqSEdwR05rS1pTM2I4a0NxQkpWL084Ti9YbUU3YjRMSW1MelVtdk9xeU1S?=
 =?utf-8?B?dy8zRlNJOU9VTlUxMWNVdG5BTTVWWXhucEJ0T2FqRFhiMno2ZVVNMG9Pc2NG?=
 =?utf-8?B?UGs0Q2ljbS9JVE9mWWRiMUh1LzVUMHhYYmx4ZlNOTnlVU1ArbEJ5MzB5NHJ2?=
 =?utf-8?B?NVlrOUlkTlh1Q1NCZlBiNmhxL01ac21aTzdWdUlYSzMyb1pkQWl4SUtmcnRH?=
 =?utf-8?B?VmlDclN3ZXFwWkN5cFdUdVh1Y245Zm1kV0FoNEhrSjVOUVVSemd3cU5YMXJM?=
 =?utf-8?B?WEFkcmJybjRwZk80L2dCaTdPZEI2TjhMb3RBWDViRGZJZkNvWEdWVmtsL3VC?=
 =?utf-8?B?dW5ITXVpYkdYM0RId1NGZkF6bWdRLzV2RkU0Rkd5ZDlPN1FmMnJRTWpvYzd6?=
 =?utf-8?B?Y0orSWxUTlhXS3FKZjhHcnQ5MTlKam4weUwveGtrZzBjV3BkSnFwRk4yRGtB?=
 =?utf-8?B?Rm9DTWdpVWJtQXBUQm9uVS9xblhhcUpHSzFFcEZMb2dBT0R4TElVUzBUNDFJ?=
 =?utf-8?B?UzJiU1M2RWh5cVpGVk1XQUVoTG93SVo0dEhZRnh3b0FTbnhlWDIyUzMyUEc5?=
 =?utf-8?B?UW9TM29ZZGFXWlNQajlqZWJMWFY2aHdVa25EeDgvTHYyZjVick5kdUZOZlZs?=
 =?utf-8?B?STVPT0lTWFFCTGpsMS9yS0Z4WU02MkFVOGR5b1hxRzNNV0FKOFdxcWpIRXU0?=
 =?utf-8?B?dnpqcGlhUVRYZzRRZmlMVCttcjRpUDNUZThzV1NPNlpPR0prUHVtVWpDbmty?=
 =?utf-8?B?SU9xVm1IcU5kbVJtYjhsNVpYOThYMjhTNFArM3dvNjBSVzdzTk92ai9mM0ZJ?=
 =?utf-8?B?bjE5UklQUTJBOGJIRktiZk1SalV4WDBLUUxhQWM5Y1FPa0lMMlEvVmxsaXNM?=
 =?utf-8?B?aHhTS2xYekJPMWoyM2Y4ZFhtYTVCN1BMMENqSVE4MWJUUlhrazJvczNmREVx?=
 =?utf-8?B?RElaY2tyNmJTT2xVU1FDbHlscEFpbFVuZzE5M0lZSmhpOXdsZ2ptb1pLMTFa?=
 =?utf-8?B?cVlvc2xaVUphSEFYaUFHSVBZYkNSamNGdEdpb01UNThWQmc5OFF2WVZjRGF4?=
 =?utf-8?B?WlRBMkJXVnF4SHhTemR0a1hkOGh2K2t5UlFXQVpUN29sNkZ2WXl5UU5CdlNY?=
 =?utf-8?B?VGxVOTdhUTJSVS9NeWhtSFB0UnREWDAydVNuZ1cyZXpEbXdkNVNYWWNxcnhu?=
 =?utf-8?B?SnJMMFc1SWlpMUZVQW5sN3BuRFF4TGNKUkMySnJFdEV2SUNVNi9MbU5XdGZz?=
 =?utf-8?B?TDEzMXlaZXBzUHBMaDRjNUpncHZFUE4xaVUvUDg0dGN0aFdmV2RpNTV1djlC?=
 =?utf-8?B?WkljSWdjVGhBWXNKSldOUzI0LzFYTkppMzJzd3A2TlRXUm9zYVJYUkhUYksv?=
 =?utf-8?B?MUp1ekx2QnkwczNadC94ZXNqcmp3OFd6ck94L3VzYTNZK0lyZFBLL0lGL0xD?=
 =?utf-8?B?NG5xYkpkOFRsWmJLeUtOSzhIOTArRVk1SjVxdXlFRTA2Um9pUklOZzZ0bEdU?=
 =?utf-8?B?ZTZyNUNjd084Z3RoSmwzZ1lsVFdpVGl2K0FQaHZ1T2dyS3ladlU0MjRMMHFR?=
 =?utf-8?B?VHlnTFVNZmU3aGNJNWhlZjFGVlI0bkh1ZDhLYXVCclpSRVhCSHBFK1JlRUtE?=
 =?utf-8?B?ZTkzczl0V0UwMjYrcFFDYmg0UTN6bkdPR2U1MTB1KzR1NXVFYlMzS25XQjVS?=
 =?utf-8?B?cXluSkJkQ2Vkdit6YlBXdmdCbi80WTh4WHE1TnFZREhtLytOSVRvcElLQ3h4?=
 =?utf-8?B?Z21ncERFQ3h4aWVPckZ5cGlUUWlWWUxOMWtsaXBsUDVwNHZoSDgwdHlWclli?=
 =?utf-8?B?aUNZN0U3eUZ1azR6eEZhenZ0aG9qTmdwMkVuRUQ5UkkrOHRZUkF1aElZemxh?=
 =?utf-8?B?Nk1SV1JLeGRhT0ptZWZ3dG5NMTFHUlg5andQQzczQitLRDBSVzNGK1ZtUUtx?=
 =?utf-8?B?TmszNWliV3c2U0trQUtPYkNndUQ0bDBYbHJ2ZEJFM1JaQ0x4dEYwdEl5WDdr?=
 =?utf-8?B?TWNRd0s2VjQrdkJkQWdYTVVaUU1LYUl2S1hzaE04bDJhOVE4NjFxQXF2ZGpR?=
 =?utf-8?B?aUh6UTY2TXZ4TDRkWVVLT0RCd1ljNTVtTHp5MElPWnU1dnNUNVNncERINW9k?=
 =?utf-8?B?Q3RjWlRwSjBKRWpJSGoxcWs2ZHUyVDBWNzl4cDQwUGVuL1VKOWNBcFN2bE4r?=
 =?utf-8?B?bERIWEpHU2lkcFBqT0gxUUliU1QzbWxNRGFTc2M5MU1yVHZtd1kreFlQSzQv?=
 =?utf-8?B?Y1QwRE5mcFZSallFazVzMHYxUUNKTmQ2VGdZcko4Yk5VOWlWWmlHR2RpQ0s5?=
 =?utf-8?B?OUxZektXL0dkbnp5a0hydnNJUjVEZ2dyMzJSeFZQdUJOSVk4YkZFZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ac0c7a2-59e4-47f1-8fc9-08de4fc4e9c8
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2026 21:20:28.9109
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NmsQJidtogUP+CTDToIlaiFL158g+eN72m2xH2aTeLLPK3VbgIOewymIrSn298n/fRRloF5iuXdCnxAFMHn+LA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7290



On 1/9/2026 9:36 AM, Frederic Weisbecker wrote:
> Le Thu, Jan 08, 2026 at 10:49:30PM -0500, Joel Fernandes a écrit :
>>>> @@ -688,6 +690,7 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
>>>>  		     bypass_ncbs > 2 * qhimark)) {
>>>>  			flush_bypass = true;
>>>>  		} else if (!bypass_ncbs && rcu_segcblist_empty(&rdp->cblist)) {
>>>> +			rdp->nocb_gp_wake_attempt = false;
>>>
>>> This is when nocb_cb_wait() is done with callbacks but nocb_gp_wait() is done
>>> with them sooner, when the grace period is done for all pending callbacks.
>>>
>>> Something like this would perhaps be more accurate:
>>>
>>> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
>>> index e6cd56603cad..52010cbeaa76 100644
>>> --- a/kernel/rcu/tree_nocb.h
>>> +++ b/kernel/rcu/tree_nocb.h
>>> @@ -746,6 +746,8 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
>>>  			needwait_gp = true;
>>>  			trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
>>>  					    TPS("NeedWaitGP"));
>>> +		} else if (!rcu_cblist_n_cbs(&rdp->nocb_bypass)) {
>>> +			rdp->nocb_gp_wake_attempt = false;
>>>  		}
>>
>> Hmm, I am trying to understand why this suggestion is better than what I
>> already have. It is one extra line and adds another conditional.
>>
>> Also shouldn't it be:
>>
>>   } else if (!rcu_cblist_n_cbs(&rdp->nocb_bypass) &&
>>              rcu_segcblist_empty(&rdp->cblist)) {
>>       rdp->nocb_gp_wake_attempt = false;
>>   }
>>
>>   ?
> 
> This else already means that rcu_segcblist_nextgp() returned false because there
> is no pending callbacks. rcu_segcblist_empty() is different because it also test
> done callbacks.
> 
>>
>> My goal was to mark wake_attempt as false when ALL callbacks on the rdp were
>> drained. IOW, the GP thread is done with the rdp.
> 
> So nocb_gp_wait (the rcuog kthreads) handle the pending callbacks, advancing
> them throughout grace periods until they are moved to the done state.
> 
> But once they are moved as done, the callbacks are the responsibility of
> nocb_cb_wait() (the rcuo kthreads) and nocb_gp_wait() stops paying attention
> to that rdp if there are no more pending callbacks.
> 
> So with your initial patch, you still have rdp->nocb_gp_wake_attempt == true
> even when there are only done callbacks. But without an appropriate wake-up
> after subsequent enqueue, nocb_gp_wait() may ignore new callbacks, event though
> rdp->nocb_gp_wake_attempt == true suggests otherwise.

Ah, got it! I was clubbing the acting of waking up rcuog to that of both the
rcuog and rcuop/s threads. Your suggestion, instead, is more accurate so I will
do it that way instead. Thanks for the explanations!

 - Joel


