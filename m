Return-Path: <linux-kselftest+bounces-16260-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F379E95EE8B
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Aug 2024 12:36:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A941A28197A
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Aug 2024 10:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54A01149018;
	Mon, 26 Aug 2024 10:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DmqLqn+w"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2044.outbound.protection.outlook.com [40.107.96.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90FE82CCC2;
	Mon, 26 Aug 2024 10:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724668593; cv=fail; b=Gd48ENeRxyJGSXmGxrAb1i+tsTbT4hqugBRp5f+FmQsdnM5vf1PIHemnRwZxxP0cMI8Y24pAt91YoJztMxDfpaAF3BLpwVVEpNCEfoffiD6mebvzwpMzU1YuOHITlLYAx9mETZg8oKHmu7j3nhwpuJZX6nyHMkFAoN3uEYoxh+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724668593; c=relaxed/simple;
	bh=M03Hf8YsrW0KReTQbENIhrJnhHRF5NEnHDW18LrOQgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hf6R8wBDzhPGoBQMvuhKnHLmuoUtLTvcevzUy1sbTmnCvxToUoGoK7VDPczTkOWPh6VkGZ73AijZcK+hyeNpoUwpyVF34OvEi4Jj/Q/HcvuK5QAQYDyh4fmp74ewM3a/SAxHZp/YFuKfwy8L4O9KDLGUB7gOQ3YKpL7MvfK3/Qs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DmqLqn+w; arc=fail smtp.client-ip=40.107.96.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uy+vdBgCcdyeDeIjjETwHwo/lNy2Xj2a7xjrWqJJKhySz5o7tA+uu4OUDif66ptHg03w1Jh5KZiVJib6faL/eriEPZOjJX+20Y1T8vi0w43Ojr3wYYBBQlIQ/BJSpI+iV1xH19RBhHlHbYt6KuWH6TFXhdpbdhOjSLcePaJ+ArG1iNNK9g7w3W7R61KcbUucAPoL1Clb7YdkGgP20NM1bOxJDzyrToPgoyzsu0hKjPBPZgaTekxTjpFDrZHszAK3W9ZoYnBoyRjQCbSxAQlKPzz72NwxOkgU9H7r31qCrlQEEfM6zqdaa0+ONOR0OIsujmEHcqqMwHjvpegXzkaUew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3WNZj//RvhfR/8Es2AybfS7JwW6JW9uNwp9wwVIcLUI=;
 b=tqWniuTE3pFiIWfg+6zTtIS+d5fbwXfJfpLj1btripwdGduvKTMufa8uRqPCNH4yK+AoxklwvL+HUJyWRVoqG2O6qetky9Ut0+V92Y4LqqH3MhQuH60Mssi/F4oH/xsiPIi4AJUJW/iQcUpcJYTusUXu0kzd3cxUfs6znCOPUaBiXiZlaIA8nm52MMTHQDPsZS2ntrYUsunOnHuoXO/FxQdQqtySwo65Q5Q5y1vJvGYGmMER4sT0mGJAHl5v4viGrsgAaMxw3Wbo7AcaFInbi7IvDeA7tThoFOy5JtbeppCBXKgDEIevjZLmeOuvR3hKmkiJGD1HkTp0s3krAme5cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3WNZj//RvhfR/8Es2AybfS7JwW6JW9uNwp9wwVIcLUI=;
 b=DmqLqn+wpiffPoPHjPx6Y5jrFzs80i1GOsLbFYH6o0EI7eOH892zoov/ge5Im18V6dJDIamaan/sC9CwoSfPqC9tqGwtKC9u3kRZqT0HF4Ak4fVZDjxW9QEQn3M8SvXkuypazaeR3rvnpSrI4y3GIP5Q8QA/tPm9PJF1zqb/6S+OGMMF2sO5blmTu99MYetttiGGcPnFyZlKiclqc44E29cGzKRP3diQhfKTL7KNN3fLP2VpMZH3IRJwaP0lnQp1z+I875h+twT9H/CrkQLvB1hxnAfw0G77EMETjPYxYAt2yOs6eIJKbwT/l597SlhVNV3QaA4/P3BVxdQdN6/jAw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN1PR12MB2558.namprd12.prod.outlook.com (2603:10b6:802:2b::18)
 by IA1PR12MB6161.namprd12.prod.outlook.com (2603:10b6:208:3eb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Mon, 26 Aug
 2024 10:36:27 +0000
Received: from SN1PR12MB2558.namprd12.prod.outlook.com
 ([fe80::f7b1:5c72:6cf:e111]) by SN1PR12MB2558.namprd12.prod.outlook.com
 ([fe80::f7b1:5c72:6cf:e111%3]) with mapi id 15.20.7897.021; Mon, 26 Aug 2024
 10:36:16 +0000
Date: Mon, 26 Aug 2024 13:35:55 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Petr Machata <petrm@nvidia.com>
Cc: Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Amit Cohen <amcohen@nvidia.com>,
	Benjamin Poirier <bpoirier@nvidia.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>, mlxsw@nvidia.com
Subject: Re: [RFC PATCH net-next 1/5] selftests: forwarding: Introduce
 deferred commands
Message-ID: <Zsxai0ACHxfbwH-t@shredder.mtl.com>
References: <cover.1724324945.git.petrm@nvidia.com>
 <d5f8364b42f277daa9e235d23398e3dce5549e92.1724324945.git.petrm@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5f8364b42f277daa9e235d23398e3dce5549e92.1724324945.git.petrm@nvidia.com>
X-ClientProxiedBy: LO4P123CA0434.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a9::7) To SN1PR12MB2558.namprd12.prod.outlook.com
 (2603:10b6:802:2b::18)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PR12MB2558:EE_|IA1PR12MB6161:EE_
X-MS-Office365-Filtering-Correlation-Id: 752da021-f6da-47bf-6030-08dcc5baea25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?D8tzDPYgIkh85iLwSsVrZjS+HmI9K/ssei+f+rXcvYTR1L4E7wBpkGdNFP4f?=
 =?us-ascii?Q?KTFqxNZzcMzm+6uOut9blBDbYRxvh1MwAfFrYNE4z6U2bhT5i2kfODyjE2uw?=
 =?us-ascii?Q?6yhiLafQCALKhdlR8Ph7XRH0eyLLRgl3qODuFrpEUS8wtHrVzdc1Ghk4mHj9?=
 =?us-ascii?Q?9hTVNLbPBDpuFJRfyEr2NOI4Ajz4ycBaSzk5TG/Bytx/aSkpTQSbNDAfVS4Y?=
 =?us-ascii?Q?N0lC2CJfaggF1AZC5HcbZyrc17qs/watROGtCFl1P738ITrP4+6XeWwMvgM6?=
 =?us-ascii?Q?TpCepsG57LSzkTaRdcV4zNc4HsIie+P3W4VPk0mgsnB6DnQ56PJFf2e/r2Ls?=
 =?us-ascii?Q?O9nSt6AHF5HEHT2VVL1azFSEj4SR6MXoKpRyE5YIb/V5eAvZLbfr3KI+vf1b?=
 =?us-ascii?Q?vxef7nOuXiMB8qT3DwXyG89/iF51p0wwKq1xNjZirNJ7jKYuZJcxqdBlmEKl?=
 =?us-ascii?Q?tgmrLaltDllKfxrUZk2NUnc75+JaaiUb2VAMGWyOKx5SzNa2jiJSpZdc+TjG?=
 =?us-ascii?Q?a+qJDhPn9K74kJcmHgxHTKzGV/kORdoucNxSQNOXQXEcZ544sD4sqYxoXwvS?=
 =?us-ascii?Q?f5WOV9oi3qKZbLJ2GFXRD23sbJ17iNxsCvYfLW+/P8Q6mQEiEG4R3JoaCF2J?=
 =?us-ascii?Q?mVPVlgYGArUc3j7GBT5IEKrNJEJUaJ/ZAb47xexMiL3lYjoK0qSI2mRdsp0N?=
 =?us-ascii?Q?EY7dsoX4XeOZlr3VnZy2p50RzBXN1IxthMhw57UfF9ivkbc6NM0bysbLsNjp?=
 =?us-ascii?Q?XTEOF0IpRI8kNOF9jhC2L7axdRGLMBMWuaSVDg36R7VQZ07M40wSRZTQPRe2?=
 =?us-ascii?Q?aN7zSyhJhZC0xjTJeJ8MYcXj9EK9jDoRW1xUQcIrjWQyk50gM94H4eU1gROW?=
 =?us-ascii?Q?6kboELs+wnVGNLb9LtjmZ4FAQcW9vjnDRvIQJR3JJNTw/ZuXeg8KGiJ7+TDo?=
 =?us-ascii?Q?QLT2HGoFTx4PFa7/ZLW4fkQI2if5/ZkQV58yB/Wzmhw0Ko2B+8O4TuPFvjs+?=
 =?us-ascii?Q?tbuG1dOmDG5A5dPrDHYY8xUNWt8SIG36XwIrS8RYAaMESe9CYT3QvYrx/AcW?=
 =?us-ascii?Q?Rk8oQA//PP1AuLKTd6seQL/4OwrG0IPh2tNqCfvk3r4O0/78BnFDrbtaXJG+?=
 =?us-ascii?Q?uEVB2C8THDlJB5OWjUniuS8SNaFAlLJTUwf6c3wfGAxlS/Krio91WQ3pgljl?=
 =?us-ascii?Q?S8ERLbhrw8zhZVQHDcCuII+fPpVQPpm8VQC3aqVHpwdHfE/EHviTRMKYonb3?=
 =?us-ascii?Q?jq9PYZXsAGVibPB8xE+pwKyDseBvE4GeI55coy5KEIEa8JbqR07lq/VTdxAL?=
 =?us-ascii?Q?nKNQJmlk9saYi4XiwB73mN2Z7aEn0mvLZFmMnkIJRDFsTQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN1PR12MB2558.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8YwXwrDr0/7t1YXnBNScnwDmR+4VJFNHZ3o24OQqgrr1mQ2ywLVLldcQiYzX?=
 =?us-ascii?Q?ClEWKNw2UMfzXf7DIDzNxPP3NiH6uCGUa9e/mAZriZovGmcaWFFy7IZNNMdi?=
 =?us-ascii?Q?69ISfrnh4UtIgMujX1kp/J7liYRfwkSMrnboIjDDuVtC1VowOEGE6lFeRUP6?=
 =?us-ascii?Q?Nc2BC8Zozd1f7HXHFROBBrN0FSk7f7OxcjF/VmDoGJRl8d6j1SkMbdNxOY8Y?=
 =?us-ascii?Q?k7aJ/bWl8lAxzCWKiQJV+B4Pc94fZeAxgnVfP2rPEr6m61WoWLSaitzEs+rP?=
 =?us-ascii?Q?S9x0vYFJr8Z8ji7wVt2YD1Fc+8VIOMP8KzzRRU7pUdEKmNN3keaCSJGbTnCB?=
 =?us-ascii?Q?826UiNubH9TrW6L6wTLyd2/U9sIW/4w1lcVZmN5fjFjIC7iLZu7h5pqfl/C2?=
 =?us-ascii?Q?1ga94hTangbDo8SvQHSGgyB4F7hY749rQWtenzanMW5ezzeFTgHvV8ETXdWI?=
 =?us-ascii?Q?Y/txNDU9/xQUNALgTj/RLSgzX1rBt6XQMQKdJ27tjA7Pw72EdmzA0MSHgZph?=
 =?us-ascii?Q?bbKH5c2IrgnCiu15Gitq7ODPiMtCKYBeX5XNdFVLJA7/1LWH1RAFL/8uGGwc?=
 =?us-ascii?Q?sBJqqAQTt7AOfcQEJD+jhnkkXI2atgnzbUHWBZ5yJ9Y54XaKRLiQGF2lxNC6?=
 =?us-ascii?Q?7zJD+U6W294rZVS9HT++CCsM9uZotlcTjHpTl7SCQUhoNoT5HL25U9VM+GJ/?=
 =?us-ascii?Q?rBXJbUZ/DEsxF4kGNBp0ylv35OOG+jo+0VwhE9MYpcb6+37bQcwxWxaxx3BJ?=
 =?us-ascii?Q?AzdhbqTbBcIqYsa0mjl92Uxk270WpI1h2KezquOfTCjpOAfrSKHfMNzpJG/o?=
 =?us-ascii?Q?MDioNzmTHOBbcBMWgIEgsfNtvGx8ZOdNAS0STeIoiPKceQUbt3E3PyWdxMBW?=
 =?us-ascii?Q?m1rk+b7qPCRpwsnmC5Be4Ai4uXyxqRGq4//00IV3ZlKTvJ6fLr4otoGiWmyC?=
 =?us-ascii?Q?KXQgF7FRfyQdcGI208L+KetTNcs0xVqKJjPAVBtByeoIfe+0VtAnbkx2bYtQ?=
 =?us-ascii?Q?KaA+fLSmgEFD0jrVwaurPkcx022u6QK0aYD5pwLV1ve5RUI8dLpEgvfuc/0A?=
 =?us-ascii?Q?vuZShf04FrNjvs13HmgxPeJ67hsMqFb2xbOs/uVTAggSZYGH2j1l6YKtZU57?=
 =?us-ascii?Q?oBv1eDz1+FhWXQA1d4Ig/V5bmK+ZnFcNdzgIHNz6i7GV+/3hszU73HlY8msk?=
 =?us-ascii?Q?CkufB+tDpTF9r7LZHmCHNHq0rCwCp2ZkxEYHcE4SkPw1w+V8HKIlquxQVQjq?=
 =?us-ascii?Q?0vBQLISs8sG643XFzeaNxvhEQC2xlq3l3pTFODk1RDEb03zPHqK7yblCXqZC?=
 =?us-ascii?Q?3egmUJQqTUEqcPX37QSzl5G9MhIO2eXiDETWJrTU+I//leKiS4EDkIEijc5g?=
 =?us-ascii?Q?hhwyoY0gqW3HdggX3ZPqAbSUmx76k63A76ZdhAiOR0TeJ/WN4Oih/DLfJx9U?=
 =?us-ascii?Q?ESK9zjDyOsF6RaAXbFzkvgYHNWUfMl8M24bDnd6hgFFEZLuE6cTY7ZdC9qN/?=
 =?us-ascii?Q?TAmX4tZH1Wev9w2R3IfCEf6bnw4Y7Bi6xHja03cuMvlnIwsyUzmh2+6TSIIc?=
 =?us-ascii?Q?Ocd6Biv45k1e12xduZpTkpj3chgs++BtQzQ/y05z?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 752da021-f6da-47bf-6030-08dcc5baea25
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2558.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 10:36:16.5628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R41JWahBw4yKUUZSXyhmO644pubK+O5vlHWDq6rKoHoo2Rq7gwYyGc0gi4+bP8uBcU14hFWH04USnZJ3OmtnEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6161

On Thu, Aug 22, 2024 at 03:49:40PM +0200, Petr Machata wrote:
> In commit 8510801a9dbd ("selftests: drv-net: add ability to schedule
> cleanup with defer()"), a defer helper was added to Python selftests.
> The idea is to keep cleanup commands close to their dirtying counterparts,
> thereby making it more transparent what is cleaning up what, making it
> harder to miss a cleanup, and make the whole cleanup business exception
> safe. All these benefits are applicable to bash as well, exception safety
> can be interpreted in terms of safety vs. a SIGINT.
> 
> This patch therefore introduces a framework of several helpers that serve
> to schedule cleanups in bash selftests:
> 
> - defer_scope_push(), defer_scope_pop(): Deferred statements can be batched
>   together in scopes. When a scope is popped, the deferred commands
>   schoduled in that scope are executed in the order opposite to order of

s/schoduled/scheduled/

>   their scheduling.
> 
> - defer(): Schedules a defer to the most recently pushed scope (or the
>   default scope if none was pushed.)
> 
> - defer_scopes_cleanup(): Pops any unpopped scopes, including the default
>   one. The selftests that use defer should run this in their cleanup
>   function. This is important to get cleanups of interrupted scripts.
> 
>   Consistent use of defers however obviates the need for a separate cleanup
>   function -- everything is just taken care of in defers. So this patch
>   actually introduces a cleanup() helper in the forwarding lib.sh, which
>   calls just pre_cleanup() and defer_scopes_cleanup(). Selftests are
>   obviously still free to override the function.
> 
> - defer_scoped_fn(): Sometimes a function would like to introduce a new
>   defer scope, then run whatever it is that it wants to run, and then pop
>   the scope to run the deferred cleanups. The helper defer_scoped_fn() can
>   be used to derive from one function its wrapper that pushes a defer scope
>   before the function is called, and pops it after it returns.
> 
> The following patches will convert several selftests to this new framework.

The intention is to make sure new tests are using these helpers?

> 
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> ---
>  tools/testing/selftests/net/forwarding/lib.sh | 83 +++++++++++++++++++

Does it make sense to place these helpers in net/lib.sh?

