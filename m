Return-Path: <linux-kselftest+bounces-34389-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA425ACF509
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Jun 2025 19:09:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADF841887C50
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Jun 2025 17:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67421276052;
	Thu,  5 Jun 2025 17:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="B7oz88HI";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BzhagPOs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9168927511E;
	Thu,  5 Jun 2025 17:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749143370; cv=fail; b=rqR6NVMugSS0qVJ/xjh2cRCx/bhicxCo+hzsndlvJ/ALbwA5XrezjAOa3LpqYIml4uY7iYHi5y5YGYWUUL/BYv1dih98u2A6X2764cTbv5n0211fewEnAVdYfKjMylQG5BW9NcKMEoLMFKHtRwegKTJg74U/u3FVo0Nch1MSuqY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749143370; c=relaxed/simple;
	bh=ehKsdD6gpyMIB1lQySG8PSMBLYDFFHuZ/INIWlINKmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oqnzPv6wwPvwfvubm0BTd+iluRnqWFI9AskMjC6sDJCZFwoxnsZIX+LA+QfTpCI2ZUtFa/gaglUTPNqXTToV+MEZ3/D3AP4XKyQ11kl+/1Fl/hxS3QaqmrqTJLyhP9aTgNIYjWO5pIsEiZ3SV6cl7nSkUlQj6dMukBWcDlgjyOg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=B7oz88HI; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=BzhagPOs; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 555FtXda022467;
	Thu, 5 Jun 2025 17:09:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=EOm4SPrq7e6y8ZFZq3
	j+k5f6wtc3NMmXdBdwC4IRBR0=; b=B7oz88HIofoUsPYDmP7c4R67FXnkDkqAyO
	FZpXzPrt2EwhTTAKKv5FOSlk7kk7XvijqkdggQzoiDtIk8ZYcmihvXa74t8OjMSy
	RfUCQT6Z64nliqOB9iaNkh90uJ3oMj67a7O2v43BTgS1fSverMR37qxvObZUnzKo
	aT1C+4vOtgXR90sfjXxyPaQCv2VBsmMTSpGdQxDltJezbVX5eYnKZgfG/FnNR7iE
	DPhmTfvMOcsljcXUEEZFNQNmxFA+ZqhXiZBoEsMZDVp7K1FfAFNj+HmPtPk+iFkP
	aVhr7Zw6GSLSqjYsngWze/hllwF39LM48FaQkOqxLT9y514tSdHg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 471g8gegt0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Jun 2025 17:09:17 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 555GfJxD040629;
	Thu, 5 Jun 2025 17:09:16 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46yr7cjpma-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Jun 2025 17:09:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jS73uaiIu1rJ1VHMPXhlcxMGNuqv4j4rS1qu0kjAiUdE/pyQWq9Mj+rNsJvh9PB4DWFnUDOA+JyANLzYKh4U2R6aWB7FbGDS+1qSzgH3jkOF+eLi8E679ATVYnRJmRZFLIaM/rCP3UzCzAxdgJht8oiUm8rZQ0GyOb+3FnLhjV2NsSM8lfTar+OjP8Nm0w4nBr96CDMtkga/FR4PUTllNT0/sNy1kQNU1yGwP0ues01FZr9GzmRiaHCOvOQVzIZeye1PzY6aUryo/a07qb2Igw0L6h/7GaJ77dqLeER7sFWQk+M/vRJW1aZsJE+NWCD47CE/LnR6xc02Pg31X8AtWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EOm4SPrq7e6y8ZFZq3j+k5f6wtc3NMmXdBdwC4IRBR0=;
 b=TzFSWKJMAXO+INU4SmDEWbH9e1+9iZQa1wT9lguKoEOlGGmG0HBk9sr3jeExbVwyVyV5nCtOwLkm1cKKGnWqiAU3cyph3qyPmWjK4NznSP7wlSDiaUrXP7uuexr4BrdFZmIQu5KFX5iVLmC2CngK2ZglAOfH8Z91EEaPU1NrzlaoogUqPcoFBGJI3n1zL7Ksvbvk25h9EtLplR2MGLihY3axSCpmifgKb/VJBEWOGQh4+RITEYx+wp8lPErPFotjsrvVZGQbd63uaGB9PNGOsFnB+eLrE+mvZU9T5QSRzIkcK6f2nxn6L9YB0QttrBAY/7dOcme8pQvCw9eC5bR5/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EOm4SPrq7e6y8ZFZq3j+k5f6wtc3NMmXdBdwC4IRBR0=;
 b=BzhagPOsLd6euYRBBWl1dUVTYiEKBcMxIGBaQhuV4BeKs+emwAPrsm4iQRsJRxIWwZwLLMC6OB6UYIOak1bsa8Ekpm8QGhFoI294ybwj+abVtJhyKax/I3GHugykKlDjkxWL+/qXZRPNguMAzewrbFc9WqrglYQkBuSL0/OJFG4=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS7PR10MB5998.namprd10.prod.outlook.com (2603:10b6:8:9e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.19; Thu, 5 Jun
 2025 17:09:12 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8746.041; Thu, 5 Jun 2025
 17:09:12 +0000
Date: Thu, 5 Jun 2025 18:09:09 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Mark Brown <broonie@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] selftests/mm: Fix test result reporting in
 gup_longterm
Message-ID: <976bbe1a-ef16-4006-acac-8b6be46ee5ea@lucifer.local>
References: <20250527-selftests-mm-cow-dedupe-v2-0-ff198df8e38e@kernel.org>
 <20250527-selftests-mm-cow-dedupe-v2-4-ff198df8e38e@kernel.org>
 <a76fc252-0fe3-4d4b-a9a1-4a2895c2680d@lucifer.local>
 <722628a8-f3fd-4fb9-ae04-2313a52ffb36@sirena.org.uk>
 <66db3d9e-73a6-4fcd-8abd-db65cfff49ab@lucifer.local>
 <661fc4ce-839f-4c47-bc3a-0c864e846324@sirena.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <661fc4ce-839f-4c47-bc3a-0c864e846324@sirena.org.uk>
X-ClientProxiedBy: LO4P123CA0175.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18a::18) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS7PR10MB5998:EE_
X-MS-Office365-Filtering-Correlation-Id: f871731d-7d93-4619-ca63-08dda453b19e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?b4/w02o+JwItq02m63MVCEhjvxOv7jBC8WMbdUjFPBU/rZ8cVa37pEtnN+5Y?=
 =?us-ascii?Q?s/hPOp3UrIEv9iMdxwMOANeK2L7VywNJcC+sfiBKHQUN5+D5RDDY1tr/OpyU?=
 =?us-ascii?Q?XE8jBcEZ4wtuRrvbiyipc+02NKLiKYbEc21PqcuV6nLCiJlISBlfM+9h8gJh?=
 =?us-ascii?Q?KqrNnT8U2OzevQVJnvx+egoUkm6QRa5NeRxxGlv9yP6q8bomdAtnL4G2tWIS?=
 =?us-ascii?Q?XYJdPXc2azzZT2lnL6H9PUfdtUoDBBlctS+7vMtyrLVPdVHG+SnWx4WihM/M?=
 =?us-ascii?Q?zqSOzqz4j0IlMMnJVCcOu+pZgNczwTsSvjB7MPAViHQyCaKbFGfZ484J+fMK?=
 =?us-ascii?Q?Q7xYEMymTOWPVgJLlGmmdMLbVTo0ZBV+KPzX/fFL7quyxksVvPb0LFWqFAzo?=
 =?us-ascii?Q?P4gmrA9Wz3Mf8Tjnds8qiMG1RyknIo3ixfgTk99WBw7AjzWeizllK2WI6fN9?=
 =?us-ascii?Q?GR3xlQpODaFpCcmx+o6evp0jKNmK/pO6kw97smOQapdnOyn7jmL2I7pamheG?=
 =?us-ascii?Q?6BwkAVcRvqL3zVC6QJ4L+DoiYNXQeXvoiwcrwOvxHJ0aIor+f4ExjjPeCr2e?=
 =?us-ascii?Q?Hv+fJgzx90o+7Xgz6g+Ds3yE8tE3PWXm0dL/Ge+bi2t1BXv/nd4qhbTJLDDt?=
 =?us-ascii?Q?RkuFIM2d4hYgCCFFedqb74kNw9xuDXrtvtqkkoGLxnnT1maHxs2UqKyAr1rW?=
 =?us-ascii?Q?sh+e8CrEkkaPOylhFRrwKFzPiA9xd+TCxw+SL9O539egQZKXEAMVI5btPjwr?=
 =?us-ascii?Q?gOVc9rn9wXSlChKAv3UzNeNSj99WMOMhmuxJWQdjSn+KN9dOx6zgzl5kduH+?=
 =?us-ascii?Q?EPNLkvnwVvybXZEzZy+NffEZIwB07ouOZYztgC4FN+aS3gvjZSAFasBHJx2E?=
 =?us-ascii?Q?szpoJ9OA1Tnr7bUSCwcqRAkpWm3M5cxDe8INsz98B73tqmEAtWfO/ACD2yr4?=
 =?us-ascii?Q?fzJFdxfxz4kd0jQ7XRyXSBS7WY3vAdYyjnr/CtJoXc5AfQVVNg4D2eF8s/ja?=
 =?us-ascii?Q?1JkNc0IZa6NaqI8LFcjyPcBVz82DR/jKChnRUVSNcJKwYXHNWUoNbDU8blBH?=
 =?us-ascii?Q?7HhnkG86rBcRuw+hPsf/9usHCul+OHZy8Z7YjNqGvUXSr/Ew3PsB51m2kwiu?=
 =?us-ascii?Q?iTJ05jB5V5+LWQ9TsNJpfaqtPH6ChWjhR8EhIm9Oq+aj89lNz7dRYIJLJ9do?=
 =?us-ascii?Q?y6FBvZFYVzU4w5WFEk+mdtazaPz7iRepalTcdQS/XNe0HtK5CqVKESkwN3SI?=
 =?us-ascii?Q?SRucJrBEMQ84B736qdtdjq1uPdMq8+f2MTqLAJcQCgnjKUYRxS/tGTO+f685?=
 =?us-ascii?Q?wsLQn5xIFR8+XuYHqVCaQOCuog8rSvLNP3UH6iLdSvIkasqQohRIf/zm8HOp?=
 =?us-ascii?Q?RKgk8G8I63h+Iao2sqPpv2TDvv00bVtjS2X6VIEjunVvi8vMi2S0J82BK6Gw?=
 =?us-ascii?Q?dh22tjoXC6M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qkPWVIHskb/1PE5mQdENMHi7hRsMnvyazias9PMr0G4fd5SFItLRxbohIMWg?=
 =?us-ascii?Q?MNiyFc2HGRWhC9j0Z/MK2pp5oamaoUGyUb9s63ZG2PgmS7ANgTX+qtwgCzz1?=
 =?us-ascii?Q?0MZLv+bosxDWY6NAMoOJMSfdEgksqBy03OB7EltjXAVkO70boj4ASNzZLHau?=
 =?us-ascii?Q?oEYX6N1zSXj0znIzlpSEb9wasj6JviKbz3YE/tbpeOrDid8Jg8m7BPARvGFN?=
 =?us-ascii?Q?B+bOiAYt+67c0bIRPamlUufAP+dS16IvKLhNyjl3XNCK6VDZ5O0jMFtCyGn4?=
 =?us-ascii?Q?4hchWNIA0oRP+hN8ZWsR0wyYPPGd+qvp1bVZUyzJ5GtQVvA7pZF6Z0kE0ktI?=
 =?us-ascii?Q?UJT6YuuVchSP3jRniZi8HILdG1R/x/UmvisQdcAOMYnTsIXo9WyRp0rgUgAt?=
 =?us-ascii?Q?MrdLXcpMcKJA2nC6FnTxFu9XTjIZ/YL9wimVq9YEc+qCvz8uiiYCTJ+6ZeZk?=
 =?us-ascii?Q?e6QSWfxMnPSj7aIPaPAPG3/pfcDs1Qsp4WkdP9tZboQ3n2BpOkRk8yEmxgRF?=
 =?us-ascii?Q?obnYf0caC2Pur04ydXoBg40Aw2qW/Bmm+xce+YFfO40Vs/7oIrGUIJDvIuDu?=
 =?us-ascii?Q?4HGxsERH5CGfU6TyH2b6RgX3Fo22j1f2VOERYBWEoKwFDJ7vtH0KFn4B5KVl?=
 =?us-ascii?Q?jHmdsRQF6TPU5PjUL7PU+7d1TxuW+CxzUgKV5WljSKaHMJzQUjZXjQQKW57z?=
 =?us-ascii?Q?QKVvfTlvJ3++NgI2+uN/Ktd2WspWZT5yzsCfyf6WBrtWCybK2e75p0qJ3klH?=
 =?us-ascii?Q?H4JE5t9M1B97cK5f0RsTRGQAA0bLN/hxAcjOppJLIRil18OPTB5jVbN1bQNl?=
 =?us-ascii?Q?DKtnJAnyU2jhH9dEVkn3snp+ai2gFiKrRCPUh/0Q1sVIJMixx2b1w9Q5Arta?=
 =?us-ascii?Q?h2yjMoR2vmbbKy9KOGqTol1OUgQ8XpAIZ0R3elW0IFfLuQZvau7WS4AkJXo7?=
 =?us-ascii?Q?YfRicZG3h12XHkGFT9dsdMUQqi4kDy5Y5Y7g7NgtGJbCy3pMNAHA9JkewfLq?=
 =?us-ascii?Q?SHAxH160g9PxynPGNr8ByNmofLaXCnfbEoR8f064sS2uZRHKjs+OOHhWM2wj?=
 =?us-ascii?Q?yT4h2VuGflLgzLTxelJbiCBxqyrLf0Pjl/NhFSV/z5LYyP7vscQwSi8dvBy+?=
 =?us-ascii?Q?sYHUA94fMQY70e310Xq3Oqrn7xQ8WRZiVOk4MDyCuS3EHn9zvBwBZQcD+A7Y?=
 =?us-ascii?Q?WpdEm0swQDB9dMeYkjmSdLuw3H+8j+iwZP1ejwxwCLnusXCcMjWyIJolXZg2?=
 =?us-ascii?Q?VbowykTEvCJqqE8I1JW6zv0YUXD8D4QFpk58DYl5SG6kug/Fm7R1GpTw1mhP?=
 =?us-ascii?Q?ytBOUUglWGsDrtngOmTGRre3IjyGdoyTaxxu1uQpKN81uPLUwJcxkrptRD7G?=
 =?us-ascii?Q?vc7l+C5gUx0k7DrsdbRtloaO137M1dT1ZYGu8OeVy7L1wwlfTBq8F5f2T5PO?=
 =?us-ascii?Q?V/6495sa+iMpwvJtKQYKXalxHass1iUYPpFAD1UGYehudmg7hnwoRuppur2C?=
 =?us-ascii?Q?7zFjhggr/o6jdOELy0prLfvd/9eo3UnsUyJdjwPZQC+El9GM/MejfGLfFpNe?=
 =?us-ascii?Q?Ix7XrwButHHusDhSEpxahNgjhVJJJcpX+jaYX8b4ef1cigwmrP9OEq2aLZV0?=
 =?us-ascii?Q?Dg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Tk1bszVYjAPCdp4oNSek2/77jwcEFw9O1/4Y8Ujx3ldCpL3ygdsBFq7paPpBgTOeQ6KUwZQ1qGAGENUkFn60KwMG+EumUrcGablQjN4lSPOYaZg6R8ZMvfSaSLesCSap76vpSGitZK4gmK6n77IT+mXYzxTAWHWt1wZC4PJsmvgrRa6hbJY+1WPJ9DqJb9ilXztFG9TwvfKRnFVpclTXFyi9XjSTMCDOcHcxf+GEs54d8H4qsNFaXQl/7ENn99eIecgAEd6DoCUfrQ2vRUKeu34FKVoIhQkREwG/l7X7KzAmjAkfdu4kIp52VLR3Or7aMTYHe/JckPgPt7ANgteeAfvlq2ghYKq8iVGpYneU6xxdgVpo+oFkyeZSDtaGW8Du8FL7Iecm8prl29g5wNSVKNiDJTndWSblruqaoakXjgBqKzAMNhsLR3vpsAYLijDUtxx4NiHlqpQnETKg3dtNLtkc8ul/J8mH1GsoTIgOB8LR9hNVtf+a4bFVH36FUFWCN3C/Zr7luViG+ucRzx/SgYAc/L4zb0/rvUKSxWbfJWFuPgMKqeWKWKtGv6elDoxU/Ff2P++lRuMLkTJrhc7qoKXOZKNeFaauOy9jBYjt3J4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f871731d-7d93-4619-ca63-08dda453b19e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2025 17:09:12.6766
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eFHL85S1hx9YAo6oLRT6wtc64cKWMivC/15gi7YGWqJgS54Uy/1Oiq35mdukz8IueRkqgwElAZZ6e3kH5KHL7Rc++h5rnFUeWWskbzEPVjw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5998
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-05_04,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 malwarescore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506050151
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA1MDE1MSBTYWx0ZWRfX7rBJzJnlV01u t9AAp4Y0h+CKWTKG8sxZrROQ9eV65fW9KegZ2XOTSj0iiDQe4gIuh3p6ncIA246KlRIED2VbLW8 P7xE2jhUmgBDiezfZRAIYNcIMxj/iLZGAlVvqKeH8sGrFPwqjckSnPfhqIqeq7Znu2UHcDXONCV
 8ofPMi5LWV5KEeRSO3ZBs7UAJOS+UBdXEmXUzZN7KXyxBi8V9ymsCiUEK/QZm4PFZ8lT1WesNLW SKwB0E9+Q0mEf2t7dPwrHBQntNbgk0G4vuma8kcDR4N0fDbFRwkF3u46kviGfl2ZT29cmI4ljAp tpPQyb3Z8D3n7Ihp1vSlL2WT5Wj7VEQthBIU8IXdhic+m9OOosV960svGHWDREzTPJRbr+XJj15
 QljskwRV9/q5Fha1YauC4Z9XMY1Gt78+DkDDf5uzziwa4p8UL/hN2NeWERCoQ/tio8njPmOp
X-Proofpoint-GUID: MA_zmqYk1kfF3930bSuozRdo7uQ8PfFx
X-Proofpoint-ORIG-GUID: MA_zmqYk1kfF3930bSuozRdo7uQ8PfFx
X-Authority-Analysis: v=2.4 cv=H5Tbw/Yi c=1 sm=1 tr=0 ts=6841cf3d b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=adAN1eHfBYgXc-_CuBIA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13206

On Thu, Jun 05, 2025 at 05:42:55PM +0100, Mark Brown wrote:
> On Thu, Jun 05, 2025 at 05:26:05PM +0100, Lorenzo Stoakes wrote:
> > On Thu, Jun 05, 2025 at 05:15:51PM +0100, Mark Brown wrote:
>
> > > That's the thing with memfd being special and skipping on setup failure
> > > that David mentioned, I've got a patch as part of the formatting series
> > > I was going to send after the merge window.
>
> > where did he mention this?
>
> I can't remember off hand, sorry.
>

I see his reply here and I guess it's because you now determine the result at
the top level, I see you are doing this in do_test():

+       int result = KSFT_PASS;
        int ret;

+       if (fd < 0) {
+               result = KSFT_FAIL;
+               goto report;
+       }
+

And in run_with_memfd_hugetlb():

        fd = memfd_create("test", flags);
        if (fd < 0) {
-               ksft_test_result_skip("memfd_create() failed (%s)\n", strerror(errno));
-               return;
+               ksft_print_msg("memfd_create() failed (%s)\n", strerror(errno));
        }

So previously this would skip, now it fails.

I've not double, triple checked this is it, but seems likely!

You said you had a fix

> > I mean I'd argue that making a test that previously worked now fail due to how
> > somebody's set up their system is a reason not to merge that patch.
>
> Well, it's a bit late now given that this is in Linus' tree and actually
> it turns out this was the only update for gup_longterm so I just rebased
> it onto Linus' tree and kicked off my tests.

Ack.

>
> > Better to do all of these formating fixes and maintain the _same behaviour_ then
> > separately tackle whether or not we should skip.
>
> I'm confused, that's generally the opposite of the standard advice for
> the kernel - usually it's fixes first, then deal with anything cosmetic
> or new?

I mean the crux is that the 'cosmetic' changes also included a 'this might
break things' change.

I'm saying do the cosmetic things in _isolation_, or fix the brokenness
before doing the whole lot.

Anyway there's no point dwelling on this, let's just get a fix sorted.

>
> > Obviously the better option would be to somehow determine if hugetlb is
> > available in advance (of course, theoretically somebody could come in and
> > reserve pages but that's not veyr likely).
>
> The tests do enumerate the set of available hugepage sizes at runtime
> (see the loop in run_test_case()) but detect_hugetlb_page_sizes() just
> looks in /sys/kernel/mm/hugepages/ for subdirectories and doesn't look
> inside those directories to see if there are actually any huge pages
> available for the huge page sizes advertised.  There's probably utility
> in at least a version of that function that checks.

Right yes, I mean obviously this whole thing is a mess already that's not
your fault, and ideally we'd have some general way of looking this up
across _all_ tests and just switch things on/off accordingly.

There's a whole Pandora's box about what the tests should assume/not and
yeah. Anyway. Maybe leave it closed for now :)

Cheers, Lorenzo

