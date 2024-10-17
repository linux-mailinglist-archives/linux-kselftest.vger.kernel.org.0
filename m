Return-Path: <linux-kselftest+bounces-20037-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11C829A2D7F
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 21:12:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC34528471B
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 19:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B02D821D2A8;
	Thu, 17 Oct 2024 19:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mBUd+yiG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2082.outbound.protection.outlook.com [40.107.93.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77DAB21D2DB;
	Thu, 17 Oct 2024 19:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729192345; cv=fail; b=i1uvyPGqbvm/8BJ8BJDcBrRHl9c9aV+uxspDapcwfAbNy+5olijYG6tj9GWsgZ0iySkUBcVd88Wkvi7P9fdKaovsCtSkzIhXy5GOXOmZzN74acWsVRYZx6kScaNmfTZRVjcD1pju+w3R3Ige/+iEmfrcaMQQtKSipNjsY5clR24=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729192345; c=relaxed/simple;
	bh=fIdoBfXik4Z7NbkVK4xKv9pve0gb5nCpct+djMqbtAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AV7O6nrDB6p5X/VGTHYblsIk/Ua6110vWbMwx5FySrKXwxAV2iXwwxJk6/Zam74C25S7gTbkrvrbP8zcBtza3iQNgv0MT0b0wyhtq43THuGqRBLuY2vmoew+K+BoKft6qUuj6A8I0zM4lHpIc6klEsWKCekmiOxWHUOKRM8PCEA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mBUd+yiG; arc=fail smtp.client-ip=40.107.93.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MpQCnZWXZ97eGm0JlAmNucKoXOvlm8YcwSpC/e7F+/yGDC7T1umTHuCaZk4UnY6QwtIyBdvMHQjntnDSMPjB6J0wC574W1wXBC0vW0PnSJitY+5fetZ0FZP1EAz3hnN29ewvK6whTuU4NSqX4vSMbiLPjuDeCxoAyaKrnfi19yWZdixDTDdj2wIDZU3geEi5CYI80UiWTEGoVP3NtjV2mDRzmVAzgWmD4bAtPBltitVqKToQ52bUglYCyEBRmNWTJFVX2fPFSJorRA3bWZY43qjQHrX315VfYnYa6vnjqa98mYx3S6I7mPelKweeMrCimfQob/N1jo+3TJlQNztrEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rKan89aCZAIo4cCmokCqsDY1t2NkkeyJGExByGBR+i0=;
 b=jRMTplleOtwuWk7Lb1SKkRO+aUlpAQAbbk8fK7RYS60t3oII+k2GgUXKTLCbIZKD4Z6Zzhl16YqYXpjYb77t7wG9fkYNKwthVtKaZ8VsBP3lkYWXB0orCSK8oY33+SX/RDOu0A1UwuD9WkHr55uRqxhg46FLtP+oUyg7yCj1OtkgCrxWBHTUTBNJdwob82wA2LW7+XYRGaGuszy8yFBPAPXvlEyF7GcrLGF8NOWCkGzQxTxQX4n9+Z0lfvBK4kMaxwlBuqVagb3VgiPRVWlB4uNSkGFrhBy5T+Cp8X5sV2F+Y6970c19DBXcDa8RTUyz71nE/NYw57rmyE1Ce2f4pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rKan89aCZAIo4cCmokCqsDY1t2NkkeyJGExByGBR+i0=;
 b=mBUd+yiG6axCG3CkYLO0bUt3BpTKledSmBON+OaakkGU8e8qEdihVlLOJ21qZLvooIZeImMQFYiFgVC79260E3LeMiMvsU7m0V7IbhKgQuVilyKMN9OJHmXXBbJH42Pf8TbxYIDUEPnHerLHQm3UvaZgFy3t1zyW+vs6QLnX6IeH57QhxaMuyTmC2tKYpNT7XNHAAz04Z6LFEkDMIcs55U+tmefdeIwTwDjqKBNzeMJCz3YeOgTIbvMkTHvv1mlYptaM89mO7r4XuXl5lXEg5VJzf4bIQjLniOoy3HRxk2OE+xuXjYfQLHoXBbGbBR2rEQyfPAAb3lW1Te2edYIEVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by LV8PR12MB9335.namprd12.prod.outlook.com (2603:10b6:408:1fc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Thu, 17 Oct
 2024 19:12:17 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 19:12:17 +0000
Date: Thu, 17 Oct 2024 16:12:16 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, will@kernel.org, joro@8bytes.org,
	suravee.suthikulpanit@amd.com, robin.murphy@arm.com,
	dwmw2@infradead.org, baolu.lu@linux.intel.com, shuah@kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, eric.auger@redhat.com,
	jean-philippe@linaro.org, mdf@kernel.org, mshavit@google.com,
	shameerali.kolothum.thodi@huawei.com, smostafa@google.com,
	yi.l.liu@intel.com, aik@amd.com, patches@lists.linux.dev
Subject: Re: [PATCH v3 10/11] Documentation: userspace-api: iommufd: Update
 vIOMMU
Message-ID: <20241017191216.GY3559746@nvidia.com>
References: <cover.1728491453.git.nicolinc@nvidia.com>
 <0b56b2a4e38e8f4cf3a96c4fb2ccbbf4b5c67da8.1728491453.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b56b2a4e38e8f4cf3a96c4fb2ccbbf4b5c67da8.1728491453.git.nicolinc@nvidia.com>
X-ClientProxiedBy: MN2PR13CA0021.namprd13.prod.outlook.com
 (2603:10b6:208:160::34) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|LV8PR12MB9335:EE_
X-MS-Office365-Filtering-Correlation-Id: 51b2278a-7101-41e2-8577-08dceedf9dbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?od1qcXIm5QIM2UUSYKZgqf2Lu9EM8CMft2HuuOMEesWT4Rhp3bBvHkBhjPqN?=
 =?us-ascii?Q?d5rruo0XqeJH74bRj7N4QdIYa6HQF/BOfBk38yseHdDexkG+XPuGmDN8p1LE?=
 =?us-ascii?Q?5a4EqJJx8CQwKnxtshGXYIL3+x2vSP0+WlHK/6U9Tod62ammw0NlRH0PebAO?=
 =?us-ascii?Q?BYLB2FP5xdzSJiIBXb9V5eQ2RHQGtwsMJfdWulVkESoHqjcWkUesSSsgkCsn?=
 =?us-ascii?Q?C2S6xTvu46cRw85xD2wjR7z1U8mz+NnLtxyKvl2z6ZuHwdxVs0/8zC9hJMH3?=
 =?us-ascii?Q?GkqrSQJ4g/MrAiXxP/pCBlebuAomB2GP9wNDHl291vAbvtoPZUqG50b7tOEz?=
 =?us-ascii?Q?SEMXm7FRcoLTfn9oUg4vwSD2duy/ekrDPzp67dayfUb2VQfrOqbyehtdvLXA?=
 =?us-ascii?Q?yUqCI3hqc3Zl8k8mR3hdZA5d8agRWeFLEwBMlFyc5sJjNqYhTR3N7Qvfkqzc?=
 =?us-ascii?Q?T/2hNVoJEfh2g4csft/qRAvyL7DYDe21LZEkSDfaX5kON/fUVW3p7X4SLYk0?=
 =?us-ascii?Q?1It/setZ/YI/pKLQzcCSpAtK4rFNUU2RzenTadWEkWKKrwUT53+xhqllKtiQ?=
 =?us-ascii?Q?Aiw3tHwRuuUCvPXSnNyS6ADvGqEDJPT+OGa9vnnIGPUHp2N0Cj7L+LYh9TcP?=
 =?us-ascii?Q?wXC2/dfsVs5ml+NfbLqiscxux89edhik+j/bA1DlnS3B/JYPXLHein7Nd5nH?=
 =?us-ascii?Q?HIYfO2gphelthQIgtexnTfnYRopUCuWpo+CJY1l0Yp+HpO05uPvbIcq5WawE?=
 =?us-ascii?Q?6CNEZA0KMlHDfZJqjq+D5butsKO4UPQbNiEu1i1byfhcdrKcp9lnp13NeOMd?=
 =?us-ascii?Q?a/EGPu0U0iTH3I0youZG2sQJVVXqW9Xn5OPmZpWO3OLudyw6ylq/jmYAEnMj?=
 =?us-ascii?Q?wk2aq6byNQ2X7dv+Yr3ezBbpS5hHRuJIp+io5D+v0a6QmYl7snK2dMqTpbTR?=
 =?us-ascii?Q?USHUBXOvAb0Be5q41Tbxa23EyoHXr53vjYXczQbbo534rpjHIvW4ZTiOnIWr?=
 =?us-ascii?Q?GJZWXvxnf93nJe2poCL8RgtUJsIRN0SrSjG5Tx6yVz1UkAh/pZzpijFXToQX?=
 =?us-ascii?Q?fm3sWE7SP6A7dQzYVReuHxC+oGs+etZzPJizKmRFn1+6VPAuwSZsHAxSS9qB?=
 =?us-ascii?Q?zvK43woh7uJXE0gKNN52bGN7Lu+fstbnblu4+bcNx1ZtIzmbvas5OoZ4p8Tm?=
 =?us-ascii?Q?p2ck3PihBC+Qerk+dGaP6D0cj8wFPc5IrWv2cUJMwIZzqB43YQXHxMSrfsXX?=
 =?us-ascii?Q?uQ4WIzTYT8pV+g9uNHPLZn5Xu6oWvAxvRThyU/6GPpLA3C4C2NyXmSpz5alT?=
 =?us-ascii?Q?JIRZXPlFtigGsdVmHGJGxpPZ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/7FQQLzMGwctmT288s3GU79wnSFLqqN2P1eh5zQ/wwPLpbQPfza7jg1k4n8G?=
 =?us-ascii?Q?h59CRtEuf4JK0VGU1gTtohylOWTwCt2EjXTbHh7NE3cAvw+EkL2fJGzwuDvG?=
 =?us-ascii?Q?orP/4EkFUWt9FCdHslWDV0DtaHBdGHzORXp4rFXyiLMINaxLrghWDGGlCSqM?=
 =?us-ascii?Q?OwPB5KdQNffzydl9y9iT0odb5U92nZ/HM+1rcXeZvY9su0z3jhzTuJcom4y0?=
 =?us-ascii?Q?NfWF3zpIK165mBUNAwLNEX0XzaY5ecYM66LsxlffZWiOTnwT3OJvZZbKxPJb?=
 =?us-ascii?Q?oanIbQrUxHwXQX3ly9DiWZr9QV2YW8Pf5AET5CiMkXbbtMKr5gAeD34D6TJN?=
 =?us-ascii?Q?wXxjQ6SBYbGu2Ezusik6ZrmK0E693MuuoeBnzV24HfA0nm+KJkTbODBp3CM5?=
 =?us-ascii?Q?8DVMc1mVMlrRizlJ0x6Tq1gVXk7HAt1ObmHXiiYSu4WhLeG3eAkvRVIJiLof?=
 =?us-ascii?Q?FJ7/VmHwvRV7g7D0C6zg3W7QApKfmJfm/QBw+Jqy8st4zHu1Y/U1Vx0Q2MqT?=
 =?us-ascii?Q?cf8NhAj1qJOZXKpt9zr5JAEChqGFUTyQr7cHuyLvk4qi1iTysncmRkpdhW9o?=
 =?us-ascii?Q?XlML7GpKRV9q4zYl9CwVeuWfaZGc3cgXoNe3Tn6i9IfSvQt3PanuKRWimhul?=
 =?us-ascii?Q?WGyuj7jdDexJFg6PNQlXGp+pWWFma8mNeAfoFvKiNjWMEm2yY07IbwO6KT6o?=
 =?us-ascii?Q?1IDtGjQvMh8klN42F7dL74apsEeSiyAOpBAJgP46WahjaLVBTbc4qMXPTfJh?=
 =?us-ascii?Q?99xdhfkdnhYg5GH05DfEAaR7MW1ddieAeg3Si6rklfVCZ1oDmwQe36L9EGwI?=
 =?us-ascii?Q?W98eK2nnr8fuj2Z4AFKWZjoEnXcf5/rIKec63FAISLKJmKT9UTq/fUN64ZbL?=
 =?us-ascii?Q?772unKUVWIw681TMurpg6nelFch4IRT6kBxKeYETl8uaPen8Pj1Wy0cUJxIV?=
 =?us-ascii?Q?SL3xt2Fo6F1O8O6HHWssyRTBmShzJJxB98VdEQRmQjpSblHUzaZ77337Aaoy?=
 =?us-ascii?Q?Yk+pNEHG7R8GPanrM1TA3DrSMFsqCqLNE4UiapsjSVSKHmXvpD86v+iW1Cov?=
 =?us-ascii?Q?rt3Viw5tEl3XlLUGDSCtxs+s6dzmIKDDFF77j/K1W+R9C4yDqDh5IQRG08yW?=
 =?us-ascii?Q?kTUx1hdMl4i07zS1G43kssC66riTMYshefYXA8pYr+CGsokE886eLHwvVtAc?=
 =?us-ascii?Q?JT0e96LewAaZVjPgdlnAuGcK7+vDzvEojmukwjWnRkRGDTB6Lmf0yJVDXTJW?=
 =?us-ascii?Q?aAwyh5jXcRneIFWGmGLVcUFw/xzUQSNhzpNRKh5z1+MCcWFx8B5pdNvrk3vQ?=
 =?us-ascii?Q?veYrj+fUNWyyK7B8f1r2uyGVV/Uas8H30+XnTHeeb4i0K4mdERE/ZqSkXFkJ?=
 =?us-ascii?Q?t7AFl63ZbLGLNbeSRmMLOw4+6kLNYHtiWFv8EcuV6XcIfeeaKB7s3kpkdHMN?=
 =?us-ascii?Q?2IFnLYvyZOvbp2kKpis1di9qErb1VRNBWQ47WSEHQ/0VBxOQ9fT7xf1qWQ1i?=
 =?us-ascii?Q?a3aUkJh0+GSKb50Qy7Ef7zho/SuwdKwQdvDx17XE8MGZoB8IEf7zmKXjwyjw?=
 =?us-ascii?Q?Paiwn+VS0cst/RqBHaw=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51b2278a-7101-41e2-8577-08dceedf9dbc
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 19:12:17.2605
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b6NsX0C+KX0rWorZBKs+uHtuOlSAk9XgOGoBcZde8Til0VEL3U7baPal0Q8nVK5g
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9335

On Wed, Oct 09, 2024 at 09:38:10AM -0700, Nicolin Chen wrote:
> With the introduction of the new object and its infrastructure, update the
> doc to reflect that and add a new graph.
> 
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  Documentation/userspace-api/iommufd.rst | 66 ++++++++++++++++++++++++-
>  1 file changed, 65 insertions(+), 1 deletion(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

